---
title: Send an archive of a Git repository over SSH
layout: post
tags:
  - git

type: regular
---

For a silly reason I wanted to send an archive of a local git repository to a
remote server in one command. 

Here is how you would do it over SSH, using `git archive` to create a tarball of your repository:

<!-- code[bash] -->

    $ git archive HEAD | ssh server.ltd "cat - >> /path/to/archive.tar"

For reference, here are the [`git-archive`](http://www.kernel.org/pub/software/scm/git/docs/v1.6.0.6/git-archive.html) and [`cat`](http://man.cx/cat) man pages.

