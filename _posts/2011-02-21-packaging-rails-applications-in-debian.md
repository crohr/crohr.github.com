---
layout: post
title: Packaging Rails application in Debian
published: false
---

# Packaging Rails application in Debian

While [Capistrano](http://capify.org/) is a great tool to automate the deployment of web applications, you quickly find yourself adding more and more stuff in the `config/deploy.rb`
* 

## Lessons learned while packaging a ruby application in Debian
* Do not waste too much time reading official Debian Maintainer doc <http://www.debian.org/doc/maint-guide/>. 
  Unless your application can be installed via `./configure && make && make install`, it does not tell you anything substantial.
  Too much details, without giving a clear example of what to do.
* Prefer the Ubuntu doc <https://wiki.ubuntu.com/PackagingGuide/Complete>, and that specific page on the Debian wiki: <http://wiki.debian.org/PackagingTutorial>

## So, how to package an application
* Don't try to create debian files manually: always use `dh_make` to generate a default `debian/` directory in your application folder:

        mv your-project your-project-<version>
        cd your-project-<version> && dh_make -e youremail@server.com --create-orig

* Explore newly created `debian` folder, particularly `debian/*.ex` files.

* If the only packaging job is to copy files to the correct destination, make use of the `.install` file.
  E.g. if your package is named `package-name`, you can create a `debian/package-name.install` file in which you declare which directories or files to copy:

        bin/* usr/bin/*
        config etc/your-project
        data var/db/your-project
        
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

* Once you customized the example files, remove the ones you don't need, and remove the `.ex` extension of those you'll need.
* Build the whole thing:

        dpkg-buildpackage -uc -us -d

## Example
