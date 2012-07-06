---
title: Rails3 apps to package
layout: post
tags:
  - ruby
  - debian
  - packaging
  - devops

---

I'm still thinking about [pkgr] [pkgr], and I came up with a few Rails
apps that would be nice to package as .deb:

* [Redmine](http://redmine.org) - the famous project management tool. A
  debian package already exists, but with a way too old version. I've
  been able to build a package with pkgr. Just need to test it further
  and upload it somewhere.

* [Gitlab HQ](gitlabhq.com) - a Github clone. Useful for setting up a
  private Github clone with pull requests, comments, etc.

* [barkeep](http://getbarkeep.org/) - a new code review tool.

All those projects use a mix of dependencies (MySQL, Postgres, Redis,
Git, etc.), have different configuration strategies, and some of them
have a [Procfile] [procfile] where they declare the processes to run.
Therefore it'll be a good test to see if I'm able to package them
easily.

If it works, then it'll be time to set up a continuous packaging server
hooked to Github ;)

[pkgr]: http://crohr.me/pkgr
[procfile]: https://devcenter.heroku.com/articles/procfile