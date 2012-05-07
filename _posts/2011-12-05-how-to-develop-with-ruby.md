---
title: How to develop with Ruby
layout: post
tags:
  - ruby
  - devops
  - packaging

type: regular
---

RVM - Gemsets - Bundler - Gemfiles - Dependencies - Packaging


## The Sysadmin's Dream

AKA the _production_ mindset.

Install Ruby:

    $ sudo apt-get install ruby1.8

Install the required Ruby libs:

    $ sudo apt-get install libhopefullymygemispackaged-ruby1.8

Well, we're not there yet, and anyway we might have two Ruby projects in need
of two different versions of the same library. So... what do we do?


## The Developer's Dream

AKA the... well... _development_ mindset. And Sysadmin's Nightmare.

### Managing rubies and installed gems (RVM)

I need libA with version 1.2.3 and libB with version 4.5.6 for projectC,
running on rubyX.Y.Z, and I don't want to mess around with my carefully
crafted list of system gems.

Install Ruby Version Manager ([RVM](http://beginrescueend.com/rvm)):

    $ bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

Install required ruby version from source (JRuby, Rubinius and other Ruby runtimes are also available)

    $ rvm install X.Y.Z
    $ rvm use X.Y.Z

Create a project-specific `gemset`, that will contain all the gems installed
for this project:

    $ rvm gemset create projectC-gemset
    $ rvm gemset use projectC-gemset
    $ gem install libA --version 1.2.3
    $ gem install libB --version 4.5.6

Under the hood, `rvm` creates a specific `GEM_HOME` for each `gemset`. When
you run `rvm gemset use project-gemset`, it will change the `GEM_HOME`
environment variable. In this way, the installed gems are isolated from the
gems that were installed system-wide.

So:

> RVM is for managing multiple versions of Ruby on the same machine, and
switching between them. Gemsets is a powerful feature RVM provides that
isolates gems for one application/library from the rest of your system.


### Managing dependencies (Bundler)

Wait, I'm working with other developers, and even I don't want to have to
remember the specific lib versions I want. Here comes
[Bundler](http://gembundler.com/), which is available as a ruby gem:

> Bundler makes it easy to make sure that your application has the
> dependencies it needs to start up and run without errors.

You describe your dependencies for the target project in a specific file named
`Gemfile`, that you place in your project's root directory:

    projectC $ cat Gemfile

    source "http://rubygems.org"
    
    gem "rails", "3.0.0.rc"
    gem "rack-cache"
    gem "nokogiri", "~> 1.4.2"

Then install the specified gems in your newly created ruby environment:

    $ rvm use X.Y.Z && rvm gemset use projectC-gemset
    $ gem install bundler
    $ bundle install

Bundler will fetch the requested dependencies (and check that they can be
fulfilled), and then install the gems in the specified gemset (this is
transparent for Bundler since it's based on `GEM_HOME` environment variable).

This means any developer can then install all the required dependencies by
running `$ bundle install` on their machine.

Also, some libraries come with executables (e.g. `rails`, `sequel`, etc.). If
you want to run these executables in the current dependency context, you must
use the `bundle exec` command:

    $ bundle exec rails ...

So:

> Bundler is for managing Ruby dependencies. Those dependencies
> are described in a `Gemfile` file. 

> You don't _need_ to use RVM with Bundler. They are separate tools. By
> default Bundler will install your gems in the default `GEM_HOME`
> path. When using RVM and Bundler together, RVM "tells" (by setting a
> different `GEM_HOME`) Bundler where the gems should go, and Bundler
> installs them into the RVM-folder.

### Files of interest

* Obviously there is the `Gemfile` file, which lists the dependencies required
  by your project. Commit this into your repository, be it a Ruby application
  or a gem.

* The first time bundle runs, it will create a `Gemfile.lock` file that will
  contain a dump of the library dependency tree for the gems it just
  installed. If you commit this file into your project's repository, then when
  other developers will run `$ bundle install` on their machines, they'll get
  the _exact_ same versions for the gems. If one of the developers want to
  update a dependency, he'll have to modify the `Gemfile` file and run `$
  bundle update`. Do _not_ commit this file if you're developing a Ruby gem,
  otherwise you'll be always testing against a static view of the dependency
  tree your gem is using, which is probably not the one that your users are
  seeing.

* To avoid entering `$ rvm use X.Y.Z && rvm gemset use projectC-gemset` each
  time you work on `projectC`, you can create a `.rvmrc` file that will be
  picked up by RVM when you `cd` into the project's directory:
  
        projectC $ cat .rvmrc
        rvm use ruby1.9.2@projectC-gemset --create

  You may commit this file into the project's repository, but only if it's a
  Ruby application, not a Ruby gem.

* There is also a `.bundle/config` file, which contains the Bundler
  configuration for the project. This is especially useful (and must be
  shipped with the project) if you're using Bundler in deployment mode (see
  next section). Do not commit this into the repository.


## Finding a trade-off between the Sysadmin's and Developer's dreams

Where we'll talk about packaging.

* Usually it makes a lot of sense to install the Ruby version with your
  distribution package manager => Sysadmin is happy, and you get security
  patches for free. Same for standard non-ruby dependencies (`libxml2`,
  `sqlite3`, etc.)

* Vendor all the Ruby libraries you're using. Vendoring means: shipping all
  the source code of your dependencies with your project. It's usually located
  in a `vendor/` folder, and Bundler can create it for you by running it in
  deployment mode:

        $ bundler install --deployment

  You should even package Bundler in your `vendor/` directory!

        $ gem install bundler -i vendor/bundle/

  Then you just need to change the `$LOAD_PATH` in your application, so that
  Ruby looks for libraries in your `vendor/` folder first. Note that the
  installation of the gems in `vendor/` must be done on a machine that has the
  same distribution and architecture of the target machine, _unless all_ your
  dependencies are pure Ruby libraries.


## Take-Away messages

* Go crazy on your development machine. You need a quick and easy way to test
  your app on different versions of Ruby, switch between library versions,
  reinstall dependencies from scratch, etc. RVM fits the bill perfectly. And
  Bundler is the de-factor standard for managing dependencies in your
  applications (for Ruby gems just use the `.gemspec` file and point your
  `Gemfile` to the `.gemspec`).

* Once you push into production, I would go against using RVM and instead
  picking the adequate Ruby version from your distribution package manager
  (assuming that version exists). However, you should vendor any Ruby
  dependency with your project.

