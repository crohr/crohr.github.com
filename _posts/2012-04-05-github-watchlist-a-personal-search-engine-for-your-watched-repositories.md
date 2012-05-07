---
title: Github Watchlist - A personal search engine for your watched repositories
layout: post
tags:
  - github
  - elasticsearch
  - api
  - projects
  - node.js

type: regular
---

Just finished a small personal project: [Github Watchlist] [watchlist], a search engine that allows me to search into all my watched repositories on Github, with full-text indexing of all the README files of the projects. Here is an example query: <http://watchlist.crohr.me/crohr?q=rest+http>.

I created this because I find the Github search engine to be mostly useless. Sometimes I know I favorited (watched) a project, but can't remember the name. And it seems like Github's engine does not search into the READMEs, only the project's descriptions (at their scale, I guess they have good reasons to do this?). Which leads to average results (at least in my case).

The app uses [Node.js] [nodejs], [Express] [express], the [Github API] [githubapi], and the awesome [Elasticsearch] [elasticsearch] engine. It's crazy how easy it is to integrate and build on all those things so quickly.

This project is mainly targeted at myself, but if you're interested you can try to [create your own search engine] [watchlist].

[express]: http://expressjs.com/
[nodejs]: http://nodejs.org/
[githubapi]: http://api.github.com/
[elasticsearch]: http://elasticsearch.org/
[watchlist]: http://watchlist.crohr.me/
