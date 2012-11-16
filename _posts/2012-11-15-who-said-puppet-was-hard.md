---
title: Who said Puppet was hard?
layout: post
tags:
  - devops
  - puppet
  - talk
  - capistrano
  - sysadmin

---

Yesterday I was at the second edition of the
[Devcamp](http://www.lacantine-rennes.net/2012/11/devcamp2-si-tu-codes-tu-viens/)
in Rennes, where developers from various horizons and communities gather
to share ideas and tools related to a specific theme.

This time the theme was about deployment, and I took the lightning talk
slot to present a short demo with the goal of demystifying
[Puppet](http://puppetlabs.com/).

Indeed, Puppet (or Chef for that matter) is often seen as a tool only
used and usable in large organizations. People often think it has to be
a client-server architecture, with lots of dependencies and
configuration to setup, but the truth is that it comes with a solo mode
that is really painless to use, even for simple deployments on a single
or few machines.

If you're interested in the end result, you can just go look at the
[demo][demo] on github.

## Puppet

* Server provisioning tool.

* Can be a pain to install in a client-server setup.

* For simple installations, use the solo mode!

* The only thing to install on the remote server is the puppet gem (go
  with v2.6.x for now):

        apt-get install ruby1.8 rubygems1.8 libopenssl-ruby1.8 -y && \
        gem install puppet --version 2.6.11 --no-ri --no-rdoc

  See the last section for a [Capistrano](http://capify.org/) task to
  automate the whole thing.

## Puppet manifest

* Declares everything that needs to be installed and configured in order
  for a piece of software to be functional.

* Can be as simple as a single file, with directives such as:

    <!-- code[ruby] -->

        # site.pp
        package {"mysql-server":
          ensure => installed
        }

        service {"mysqld":
          name => "mysql",
          ensure => running,
          require => Package["mysql-server"]
        }

        exec { "allow-mysql":
          command => "/bin/echo 'mysqld: ALL: allow' >> /etc/hosts.allow",
          onlyif  => "/bin/grep -qv ^mysqld /etc/hosts.allow",
          require => Package["mysql-server"]
        }

        file { "/etc/mysql/conf.d/custom.cnf":
          mode => 644, owner => root, group => root,
          content => "[mysqld]\nbind-address = 127.0.0.1\n",
          notify => Service["mysqld"],
          require => Package["mysql-server"];
        }

* Provision the remote server with the following command (add
  `/var/lib/gems/1.8/bin/` to your `PATH` if needed):

        puppet apply site.pp

  You should see the following output:

        notice: /Stage[main]//Package[mysql-server]/ensure: ensure changed 'purged' to 'present'
        notice: /Stage[main]//File[/etc/mysql/conf.d/custom.cnf]/ensure: defined content as '{md5}6cf7741c1e6fc9baafca18e65f68d9ca'
        notice: /Stage[main]//Service[mysqld]: Triggered 'refresh' from 1 events
        notice: /Stage[main]//Exec[allow-mysql]/returns: executed successfully
        notice: Finished catalog run in 51.92 seconds

## Puppet modules

* When you have lots of things to install, you can create specific
  modules for each software component.

* Don't reinvent the wheel, lots of modules have already been created,
  that are parametrized and re-usable on various distributions. See the
  [Puppet forge](http://forge.puppetlabs.com), or search on Github.

* Use [`librarian-puppet`](https://github.com/rodjek/librarian-puppet)
  to manage your modules dependencies.

## Manage your Puppet module dependencies with librarian-puppet

* Like [`bundler`](http://gembundler.com/), but for Puppet modules.

        gem install librarian-puppet

* Example `Puppetfile`:

        forge "http://forge.puppetlabs.com"

        mod 'puppetlabs/stdlib'
        mod "puppetlabs/apt"
        mod 'puppetlabs/ntp'
        mod 'puppetlabs/apache'
        mod 'puppetlabs/firewall'
        mod 'huit/gitolite'
        mod 'alup/rbenv'
        mod 'saz/sudo'

* Then let librarian-puppet fetch the dependencies with:

        librarian-puppet install

* This will create a `modules/` directory locally, containing all the
  modules you declared in your `Puppetfile`.

* You can also reference specific Git repositories, branches, etc. See
  the `librarian-puppet` README for this.

## Usage

* Include the modules you need in a site manifest `site.pp`. For instance:

  <!-- code[ruby] -->

        include ntp

        package{"some-package":
          ensure => installed
        }

        user {"some-user":
          ensure => present,
          managehome => true,
          shell => "/bin/bash"
        }

        rbenv::install { "some-user rbenv":
          user => "some-user",
          require => User["some-user"]
        }

        rbenv::compile { "1.9.3-p286":
          user => "some-user",
          global => true,
          require => Rbenv::Install["some-user rbenv"]
        }

        class {'apache':  }

        apache::vhost { 'server.com':
            priority      => '10',
            port          => '80',
            docroot       => '/var/www/server.com',
            serveradmin   => 'support@server.com',
            ensure        => present
        }

* Make sure you have installed `puppet` on the target server.

* Upload your manifests and modules to the target server.

* Provision your server using:

        puppet apply /path/to/site.pp --modulepath /path/to/modules/

## Automate with Capistrano

* Put this in your `config/deploy.rb`

    <!-- code[ruby] -->

        set :puppet_dir, "/tmp/puppet"
        set :puppet_cmd, "/var/lib/gems/1.8/bin/puppet"

        desc "Install and configure the puppet recipes on a remote machine."
        task :provision do
          system "rm -f modules.tar.gz && tar czf modules.tar.gz modules"
          run "rm -rf #{puppet_dir} && mkdir -p #{puppet_dir}"

          upload "modules.tar.gz", puppet_dir, :force => true, :via => :scp
          upload "./config/site.pp", puppet_dir, :force => true, :via => :scp

          run "cd #{puppet_dir} && tar xzf modules.tar.gz && \
            #{sudo} apt-get update && #{sudo} apt-get install ruby1.8 rubygems1.8 libopenssl-ruby1.8 -y && \
            ( [ -f #{puppet_cmd} ] || #{sudo} gem install puppet --version 2.6.11 --no-ri --no-rdoc ) && \
            #{sudo} #{puppet_cmd} #{puppet_dir}/site.pp --modulepath #{puppet_dir}/modules/"
        end

* And then:

        HOSTS=my-server.com cap provision

* \[optional\] Finally, once your server is provisioned with everything
  you need for your main app (let's say a Rails app), you can deploy it
  using the standard Capistrano process:

        HOSTS=my-server.com cap deploy:setup deploy

## Demo

The demo started with a fresh Ubuntu 10.04LTS EC2 instance (with a
single click from the [Ubuntu Cloud image repository] [ubuntucloud]
which is great stuff by the way), and then the single Capistrano command
deployed everything on that bare server in less than 5'. For a last
minute presentation, I think it went great.

Have a look at the [demo][demo] on github.

[demo]: https://github.com/crohr/who-said-puppet-was-hard
[ubuntucloud]: http://uec-images.ubuntu.com/releases/10.04/release/

## Conclusion

If you want to get one or more servers deployed in no time, find the
Puppet modules you need on the forge or create your own simple
manifests, and use Puppet in solo mode to apply the recipes on any
number of server with a simple Capistrano task.

Also, it's likely that you can get to the same result with Chef (see the
original [Librarian] [librarian] gem, which comes with librarian-chef),
so there is really no excuse to keep using your shell scripts or
half-backed libraries to provision servers.

[librarian]: https://github.com/applicationsonline/librarian

## Resources

* [https://github.com/rodjek/librarian-puppet](https://github.com/rodjek/librarian-puppet)
  - Github repository where you can find `librarian-puppet`.

* <http://forge.puppetlabs.com> - Puppet forge, where you can find
  modules for almost everything.

* <http://docs.puppetlabs.com/references/latest/type.html> - Puppet type
reference.
