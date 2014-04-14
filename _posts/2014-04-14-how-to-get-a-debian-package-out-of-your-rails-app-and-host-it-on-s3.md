---
title: Packaging and sharing your Rails app, the easy way
description: "How to package a Ruby on Rails app, and host the resulting debian package on S3, all without the need to know about any of the debian packaging rules."
layout: post
tags:
  - devops
  - packaging
  - pkgr
  - debian
  - ubuntu
  - deb-s3
---

Software packaging is a kind of a dark art for many people, due in most part to packaging manuals and [policies][debian-policy] that are hard to understand for the busy developer, but most importantly do not address well the needs of developers who want to package a full web app (i.e. with rapidly evolving libraries, latest runtime).

[debian-policy]: https://www.debian.org/doc/debian-policy/

Today I want to introduce two tools, [pkgr][pkgr] and [deb-s3][deb-s3], which will allow you to respectively package a rails app, and host the resulting debian package on S3, all without the need to know about any of the debian packaging rules.

## Why package at all?

Packaging your app, as opposed to just sending tarballs or cloning git repos, has many advantages:

* **easy distribution**: just add a new APT repository and you can fetch the app immediately.
* **easy installation**: `apt-get install my-app` and you're done.
* **fast installation**: no need to compile anything on the server.
* **improved reliability**: if you've tested that it works on one server, deploying to many servers is a no-brainer.

Up until now, it was quite an undertaking to try packaging a Rails app all by yourself. You could use tools such as [FPM][fpm] to generate your package and any dependencies your application requires, but the main goal of FPM is to abstract package managers, not necessarily simplify the packaging of a full app with many dependencies. Omnibus is another option, but then you basically embed a full OS into your package, and the recent [heartbleed][heartbleed] vulnerability shows that it's probably not such a good idea. Also you still had to figure out how to host the packages.

[heartbleed]: http://heartbleed.com

So, let's start this tutorial with pkgr, the tool that will allow you to generate a debian package out of your app

## Prerequisites: get hold of a debian-based VM

pkgr needs to be run on the system you build the package for. That means that if you want a package for Ubuntu 12.04 (Precise), go ahead and find a machine with that distribution. You could use Vagrant, docker, or just click on the following link to start an official Ubuntu 12.04 AMI on Amazon EC2: <https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-5db4a934> (list of available Ubuntu AMIs [here](http://uec-images.ubuntu.com/releases/precise/release/)).

Then, setup the build VM:

    $ sudo apt-get update
    $ sudo apt-get install -y build-essential rng-tools git ruby1.9.1-full rubygems1.9.1
    $ sudo gem install pkgr deb-s3 --no-ri --no-rdoc

## Generating a debian package with pkgr

pkgr is basically Heroku buildpacks + FPM + peripheral stuff (init scripts, cli, etc.). If you like the way you deploy apps on Heroku, you'll probably like packaging your app.

### Get some Rails app to package

The example app we'll use is a blank Rails4 app, using postgres as the database. Note that you should be able to package any Ruby app (starting with Ruby1.8.7), with any type of database, gems, etc.

    $ mkdir ~/apps
    $ cd ~/apps
    $ git clone https://github.com/pkgr/rails4-example-app.git

### Start the packaging process

Note: The `--auto` option will try to automatically install missing build dependencies with `apt-get`, which means it can take some time before you see the `-----> Ruby app` line on a fresh build machine:

    $ pkgr package ~/apps/rails4-example-app --auto
    -----> Ruby app
    -----> Compiling Ruby/Rails
    -----> Using Ruby version: ruby-2.0.0
    -----> Installing dependencies using 1.5.2
           Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
           Fetching gem metadata from https://rubygems.org/..........
           Fetching additional metadata from https://rubygems.org/..
           Installing minitest (5.3.2)
           Installing i18n (0.6.9)
           Installing rake (10.2.2)
           Installing thread_safe (0.3.3)
           Installing builder (3.2.2)
           Installing mime-types (1.25.1)
           Installing erubis (2.7.0)
           Installing polyglot (0.3.4)
           ...
           Installing turbolinks (2.2.2)
           Installing sass-rails (4.0.3)
           Installing rails (4.1.0)
           Installing pg (0.17.1)
           Your bundle is complete!
           Gems in the groups development and test were not installed.
           It was installed into ./vendor/bundle
           Post-install message from rdoc:
           Depending on your version of ruby, you may need to install ruby rdoc/ri data:
           <= 1.8.6 : unsupported
           = 1.8.7 : gem install rdoc-data; rdoc-data --install
           = 1.9.1 : gem install rdoc-data; rdoc-data --install
           >= 1.9.2 : nothing to do! Yay!
           Bundle completed (92.63s)
           Cleaning up the bundler cache.
    -----> Preparing app for Rails asset pipeline
           Running: rake assets:precompile
           I, [2014-04-14T09:57:53.391958 #18689]  INFO -- : Writing /tmp/d20140414-15482-1nlncju/opt/rails4-example-app/public/assets/application-59ffd4525232837e51088483ed301f44.js
           I, [2014-04-14T09:57:53.624426 #18689]  INFO -- : Writing /tmp/d20140414-15482-1nlncju/opt/rails4-example-app/public/assets/application-9cc0575249625b8d8648563841072913.css
           Asset precompilation completed (15.65s)
           Cleaning assets
           Running: rake assets:clean
    -----> WARNINGS:
           Include 'rails_12factor' gem to enable all platform features
           See https://devcenter.heroku.com/articles/rails-integration-gems for more information.

           You have not declared a Ruby version in your Gemfile.
           To set your Ruby version add this line to your Gemfile:
           ruby '2.0.0'
           # See https://devcenter.heroku.com/articles/ruby-versions for more information.

As you can see, the tool detected that we had a Ruby app, fetched the corresponding Ruby version (2.0.0), and then installed all the required gems. If the process successfully ended, you should now have a `.deb` file containing the result of that building process, in the directory from where you launched the `pkgr` command:

    $ ls -t
    rails4-example-app_0.0.0-20140414100914_amd64.deb  config.ru  log     vendor   Gemfile.lock
    bin                                                db         public  app      Rakefile
    config                                             lib        test    Gemfile  README.rdoc

Please refer to the [pkgr][pkgr] website to know more about the various options you can pass to the `package` command. Also, further calls to the `package` command will be much faster, since the result of the `bundle install` runs are cached.

Now, let's release the newly generated package on S3!

## Host your newly created debian package on S3

### Create a new gpg key

This will be used to sign the release file of your APT repository. If you don't already have a gpg key you want to use, then you can generate a new one by doing:

    $ sudo rngd -r /dev/urandom # needed to generate enough entropy on remote servers
    $ gpg --gen-key # choose default options, enter a name and email address, and you can choose to keep the passphrase blank if you wish.

You should now have a new gpg secret key:

    $ gpg --list-secret-keys
    /home/ubuntu/.gnupg/secring.gpg
    -------------------------------
    sec   2048R/CF0B4573 2014-04-14
    uid                  Cyril Rohr <hi@pkgr.io>
    ssb   2048R/7198E0E7 2014-04-14

Note the key ID (here: CF0B4573).
Also, for all things related to gpg, this [cheatsheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/gpg-cs.html) can be useful.

### Upload the debian package

This part assumes that you have signed up for an Amazon AWS account, and that you have created a new S3 bucket to host your APT repository. We'll be using the `deb-s3` tool to manage our APT repository on S3. The good thing about deb-s3 is that it does not need to keep the full repository in sync on the disk: it just updates the metadata files when you add a new package.

Let's set up a few environment variables:

    $ export S3_BUCKET="my-apt-bucket"
    $ export AWS_ACCESS_KEY="key"
    $ export AWS_SECRET_KEY="secret"

Now, upload your package:

    $ deb-s3 upload \
      --bucket ${S3_BUCKET} \
      --codename precise \
      --component master \
      --preserve-versions \
      --visibility public \
      --access-key-id "${AWS_ACCESS_KEY}" \
      --secret-access-key "${AWS_SECRET_KEY}" \
      --sign CF0B4573 \
      ~/apps/rails4-example-app/rails4-example-app_0.0.0-20140414100914_amd64.deb
    >> Retrieving existing manifests
    >> Examining package file rails4-example-app_0.0.0-20140414100914_amd64.deb
    >> Uploading packages and new manifests to S3
       -- Transferring pool/r/ra/rails4-example-app_0.0.0-20140414100914_amd64.deb
       -- Transferring dists/precise/master/binary-amd64/Packages
       -- Transferring dists/precise/master/binary-amd64/Packages.gz
       -- Transferring dists/precise/master/binary-i386/Packages
       -- Transferring dists/precise/master/binary-i386/Packages.gz
       -- Transferring dists/precise/Release
       -- Transferring dists/precise/Release.gpg
    >> Update complete.

That's it, you now have a debian package hosted on S3!

Now, let's see how your users can install it, and launch the application.

## Install the package from the newly created APT repository

Add a new entry to your list of APT repositories:

    $ echo "deb https://s3.amazonaws.com/my-apt-bucket precise master" | sudo tee /etc/apt/sources.list.d/my-repo.list

Import the public gpg key (replace `CF0B4573` with your key ID), so that APT knows about your signature:

    $ gpg --export -a "CF0B4573" | sudo apt-key add -
    OK

Note: In the real world, your public key would probably be hosted in your S3 bucket, and users would retrieve it like this:

    $ wget -qO - https://s3.amazonaws.com/my-apt-bucket/key | sudo apt-key add -

Finally, install the package:

    $ sudo apt-get update
    $ sudo apt-get install -y rails4-example-app
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following extra packages will be installed:
      libreadline5
    The following NEW packages will be installed:
      libreadline5 rails4-example-app
    0 upgraded, 2 newly installed, 0 to remove and 26 not upgraded.
    Need to get 24.9 MB of archives.
    After this operation, 87.1 MB of additional disk space will be used.
    Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ precise/main libreadline5 amd64 5.2-11 [128 kB]
    Get:2 https://s3.amazonaws.com/my-apt-bucket/ precise/master rails4-example-app amd64 0.0.0-20140414100914 [24.8 MB]
    Fetched 24.9 MB in 2s (10.2 MB/s)
    Selecting previously unselected package libreadline5.
    (Reading database ... 72529 files and directories currently installed.)
    Unpacking libreadline5 (from .../libreadline5_5.2-11_amd64.deb) ...
    Selecting previously unselected package rails4-example-app.
    Unpacking rails4-example-app (from .../rails4-example-app_0.0.0-20140414100914_amd64.deb) ...
    Processing triggers for ureadahead ...
    Setting up libreadline5 (5.2-11) ...
    Setting up rails4-example-app (0.0.0-20140414100914) ...
    Processing triggers for libc-bin ...
    ldconfig deferred processing now taking place

pkgr installed the app files into `/opt/rails4-example-app`:

    $ ls /opt/rails4-example-app/
    app  bin  config  config.ru  db  Gemfile  Gemfile.lock  lib  log  public  Rakefile  README.rdoc  test  tmp  vendor

And it indeed uses Ruby 2.0.0:

    $ sudo rails4-example-app run ruby -v
    ruby 2.0.0p451 (2014-02-24 revision 45167) [x86_64-linux]

To finish the tutorial, let's get it up and running, by installing a postgres database, playing with the console, and starting a web daemon:

    $ sudo apt-get install -y postgresql-9.1
    $ echo "CREATE USER \"user\" PASSWORD 'pass';" | sudo su - postgres -c psql && \
      echo "CREATE DATABASE rails4_example_app;" | sudo su - postgres -c psql && \
      echo "GRANT ALL PRIVILEGES ON DATABASE \"rails4_example_app\" TO \"user\";" | sudo su - postgres -c psql

    $ sudo rails4-example-app config:set DATABASE_URL="postgres://user:pass@127.0.0.1/rails4_example_app"
    $ sudo rails4-example-app config:set SECRET_KEY_BASE=$(sudo rails4-example-app run rake secret)

    $ sudo rails4-example-app run console
    Loading production environment (Rails 4.1.0)
    irb(main):001:0> Rails::VERSION::STRING
    => "4.1.0"

    $ sudo rails4-example-app scale web=1
    Scaling up...
    rails4-example-app-web-1 start/running, process 2030
    rails4-example-app-web start/running
    rails4-example-app start/running
    --> done.

    $ ps aux | grep ruby
    106       2030  0.1 11.5 349560 69896 ?        Ssl  11:17   0:02 ruby bin/rails server -p 6000 -e production

Looks like everything is running fine, so `curl localhost:6000` should give you the expected HTML output:

    $ curl localhost:6000
    Hello from Rails4 Example App!

Success!

If you want to access your app on port 80, you could set up a proxy directive in nginx:

    $ sudo apt-get install -y nginx
    $ sudo tee /etc/nginx/sites-available/default <<EOF
    server {
      listen          80;
      server_name     example.com;
      location / {
        proxy_pass      http://localhost:6000;
      }
    }
    EOF
    $ sudo service nginx restart

Now, `curl localhost:80` or `curl hostname-of-the-machine:80` should give you the same result.

You can also restart the Rails app using the provided init script:

    $ sudo service rails4-example-app restart

And should you need to do anything to finish setting up your app, arbitrary commands can be run (in the context of your app's Ruby version, gems, etc.) with the command line tool that was automatically generated by pkgr:

    $ sudo rails4-example-app run rake db:migrate
    $ sudo rails4-example-app run rake -T

That's it!

## Conclusion

As you can see from this tutorial, packaging a Rails app, and hosting the resulting package on S3, just became a lot easier with tools such as [pkgr][pkgr] and [deb-s3][deb-s3]. pkgr can also be used to package NodeJS apps, and in the near future will be able to generate RPM packages as well.

If you like what you've seen, but would like a bit more automation, please have a look at [pkgr.io](https://pkgr.io), the hosted service I created based on pkgr. You can enable a new project for packaging in one click, and it supports multiple targets.

Thanks for reading!

[pkgr]: https://github.com/crohr/pkgr
[deb-s3]: https://github.com/krobertson/deb-s3
[fpm]: https://github.com/jordansissel/fpm
