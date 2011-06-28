---
layout: post
title: How to Copy an Archive of a Git Repository over SSH
published: true
---

# How to Copy an Archive of a Git Repository over SSH
For a silly reason I wanted to send an archive of a local git repository to a
remote server in one command. 

Here is how you would do it over SSH and using `git archive`:

    git archive HEAD | ssh server.ltd "cat - >> /path/to/archive.tar"

For reference, here are the [`git-archive`](http://www.kernel.org/pub/software/scm/git/docs/v1.6.0.6/git-archive.html) and [`cat`](http://man.cx/cat) man pages.
