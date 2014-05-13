---
title: Fixing postgres UTF-8 encoding error when creating new databases
description: "Quick tip to fix the dreaded PG::InvalidParameterValue: ERROR: encoding UTF8 does not match locale en_US. DETAIL: The chosen LC_CTYPE setting requires encoding LATIN1."
layout: post
tags:
  - rails
  - postgres
  - tip
---

Quick tip, mainly as a reference for myself.

I wanted to create a new postgres database from Rails, here is what I did:

    $ sudo apt-get install -y postgresql-9.1
    $ sudo -u postgres createuser myuser --createdb --no-superuser --no-createrole
    $ ./bin/rake db:create
    PG::InvalidParameterValue: ERROR:  encoding UTF8 does not match locale en_US
    DETAIL:  The chosen LC_CTYPE setting requires encoding LATIN1.
    : CREATE DATABASE "my-database" ENCODING = 'utf8'
    ...

Looks like my locales are wrong. Here was the result of calling `locale`:

    $ locale
    LANG=en_US.UTF-8
    LANGUAGE=
    LC_CTYPE="en_US"
    LC_NUMERIC="en_US"
    LC_TIME="en_US"
    LC_COLLATE="en_US"
    LC_MONETARY="en_US"
    LC_MESSAGES="en_US"
    LC_PAPER="en_US"
    LC_NAME="en_US"
    LC_ADDRESS="en_US"
    LC_TELEPHONE="en_US"
    LC_MEASUREMENT="en_US"
    LC_IDENTIFICATION="en_US"
    LC_ALL=en_US

As you can see, I have `en_US` values that should be `en_US.UTF-8` instead. Looking on the internet, you can see various ways of fixing it for a specific database by creating the database directly with the `psql` CLI, and forcing `lc_ctype` & co.

To definitely fix it, the fastest way I found is to do as follows:

1. Make sure you've got your locale properly generated:

        $ sudo locale-gen en_US.UTF-8

1. Update the `/etc/default/locale` file with the corresponding variables (or use `update-locale LANG=xx LC_CTYPE=xx ...`):

        $ sudo cat - > /etc/default/locale <<EOF
        LANG=en_US.UTF-8
        LANGUAGE=
        LC_CTYPE="en_US.UTF-8"
        LC_NUMERIC="en_US.UTF-8"
        LC_TIME="en_US.UTF-8"
        LC_COLLATE="en_US.UTF-8"
        LC_MONETARY="en_US.UTF-8"
        LC_MESSAGES="en_US.UTF-8"
        LC_PAPER="en_US.UTF-8"
        LC_NAME="en_US.UTF-8"
        LC_ADDRESS="en_US.UTF-8"
        LC_TELEPHONE="en_US.UTF-8"
        LC_MEASUREMENT="en_US.UTF-8"
        LC_IDENTIFICATION="en_US.UTF-8"
        LC_ALL=en_US.UTF-8
        EOF

1. Remove postgres (necessary because it looks like the default postgres locale is set at install time based on your system's locale):

        $ sudo apt-get remove postgresql-9.1 ...

1. Reinstall postgres

        $ sudo apt-get install postgresql-9.1

1. Open a new terminal session (you can also probably just reload your `~/.bashrc`), and start again:

        $ sudo -u postgres createuser myuser --createdb --no-superuser --no-createrole
        $ ./bin/rake db:create
        # success!

This is most probably not the easiest way to do it (please let me know in the comments), but it works.

Conclusion: Next time, always make sure you correctly set the locales before installing anything :)