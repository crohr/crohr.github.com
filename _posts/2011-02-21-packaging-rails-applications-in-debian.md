---
layout: post
title: How to package Rails application in Debian
published: false
---

# How to package Rails application in Debian

Until a few weeks ago, I used [Capistrano](http://capify.org/) to deploy software at work. While it is a fine tool to automate the deployment of web applications, it has the following shortcomings:

* Very limited dependency support;
* `cap deploy:setup` phase before being able to `cap deploy`;
* Excessive reliance on the availability of your servers to successfully deploy the application (if one of the servers is not reachable when you want to deploy, you'll have to cancel the operation or modify your configuration);
* You can never be 100% sure that a `cap deploy` will still work as expected 1 week from now (changes in local or remote configuration can make your deployment fail);
* Limited support for things such as `init.d` scripts;
* Limited rollback support.

When you use tools such as Puppet or Chef to automate the configuration of your servers, the Capistrano workflow becomes a time-consuming task and a single point of failure. When you have multiple applications to deploy that way, it becomes fairly unmanageable.

Fortunately, your distribution's native package manager (APT, YUM, etc.) can be used to produce a binary package, and will correctly manage and install dependencies, copy files and folders around, install `init.d` scripts, set up cron tasks, and execute operations before and after installation/removal/upgrade. And best of all, you'll just have to execute a one-liner to install/update your application. For instance with APT:

    apt-get update && apt-get install my-app

Some people might argue that you can quite easily package a Rails app as a Ruby gem, but that only works if your application is fairly simple, since Rubygems only deal with dependencies on gems, install/uninstall/update, but no pre/post hooks for any of these steps, and no way to install things outside of the Rubygems directory. This is nonetheless a nice way to get a cross-distrib package rapidly if you can.

In the next parts of this post, I'll explain how to produce such a package for a Rails3 application requiring Ruby 1.9.2, for Debian-based systems (`.deb` packages). There are a lot of tutorials around the web that tell you how to package things, but they're all targeted at software that installs with `./configure && make && make install`, which is definitely not the case of your standard Rails app.

**Disclaimer:** I'm sure some of the steps I made are dirty or just plain wrong, so if there are guys familiar with Debian packaging reading this post, feel free to point errors and better ways to do it.

## Setting up a build environment
If your development environment is not Debian-based, I strongly advise to setup a virtual machine running the latest Debian stable. In the following paragraphs, I'll assume that VM can be accessed via:

    $ ssh debian-build

To build packages, you'll have to install a few development libraries:

    $ ssh debian-build
    debian-build $ sudo apt-get update && sudo apt-get install XX

Install Ruby 1.9.2. For that we'll use the `ruby1.9.1-full` package from the `debian-backports` since it comes with a recent version of Rubygems (1.3.7).

    $ echo "" > /etc/apt/sources.list
    $ sudo apt-get update && apt-get install ruby1.9.1-full

Your Rails app will have gem dependencies. Since they will probably not be packaged by default in Debian, or if present, will be outdated, you have two choices here:

1. Package every gem that your application depends on (the [`fpm`]() tool is a quick and dirty way to produce all the required packages);
2. Use [`bundler`](http://gembundler.com/) to vendor your dependencies, that will be packaged along with your app (quite dirty, but it's simple and it won't break if multiple apps need multiple version of the same gem).

Since `bundler` is the way to go with Rails apps, it makes sense to only package `bundler`, and vendor all your dependencies.

To produce a `.deb` package for `bundler`, launch the following on your build machine:

    debian-build:~$ gem install fpm
    debian-build:~$ gem fetch bundler && fpm xx bundler*.gem

If everything goes well, you should now have a `bundler_xxx_.deb` file in `~/`.

If you want further reference on the packaging process, here are a few links and a few things I learned while trying to make my first `.deb` package:

* Do not waste too much time reading the official Debian Maintainer documentation at <http://www.debian.org/doc/maint-guide/>: Unless your application can be installed via `./configure && make && make install`, it does not tell you anything substantial.
* Prefer the Ubuntu documentation <https://wiki.ubuntu.com/PackagingGuide/Complete>, and that specific page on the Debian wiki: <http://wiki.debian.org/PackagingTutorial>
* 

## Create and customize your Rails project    
Create a new Rails project:

    $ rails new app-to-package
    $ cd app-to-package

Debian packages expect certain things to be put in specific locations: configuration files will be put in `/etc/app-to-package/`, log files in `/var/log/`, etc. We'll have a few changes to make to accommodate these requirements (you're not required to do so, but it's better to stick to Debian guidelines where you can, the package managers do a lot of things for you if you respect the guidelines):

* Move YAML configuration files to a specific directory, so that it can be easily linked to `/etc/app-to-package`;
* Change the way Rails looks for configuration files.

## Debianize your Rails application

    ~/app-to-package $ dh_make

A few things you need to know:

* Don't try to create debian files manually: always use `dh_make` to generate a default `debian/` directory in your application folder.
* Never try to put things in `/usr/local/` (Debian Policy) or you'll get cryptic errors such as:

                 dh_usrlocal
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/oar.rb is not a directory
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/kadeploy.rb is not a directory
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/version.rb is not a directory
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/oar/resource.rb is not a directory
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/oar/base.rb is not a directory
              dh_usrlocal: debian/g5kapi/usr/local/g5kapi/lib/oar/job.rb is not a directory
              	"rmdir debian/g5kapi/usr/local/g5kapi/lib/oar"
              rmdir: failed to remove `debian/g5kapi/usr/local/g5kapi/lib/oar': Directory not empty
              dh_usrlocal: command returned error code 256
              make: *** [binary] Error 1

## Setup your own debian repository

## Setup rake tasks for streamlined build and release process

## References
* How to build RPM packages.

<!-- 
        mv your-project your-project-<version>
        cd your-project-<version> && dh_make -e youremail@server.com --create-orig

* Explore newly created `debian` folder, particularly `debian/*.ex` files.

* If the only packaging job is to copy files to the correct destination, make use of the `.install` file.
  E.g. if your package is named `package-name`, you can create a `debian/package-name.install` file in which you declare which directories or files to copy:

        bin/* usr/bin/*
        config etc/your-project
        data var/db/your-project
        
* Once you customized the example files, remove the ones you don't need, and remove the `.ex` extension of those you'll need.
* Build the whole thing:

        dpkg-buildpackage -uc -us -d
-->