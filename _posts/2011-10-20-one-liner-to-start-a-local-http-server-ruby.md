---
title: One-liner to start a local HTTP server [ruby]
layout: post
tags:
  - ruby

type: regular
---

Wow, is it really what it takes to start an HTTP server serving static files
from the current directory with standard Ruby?

<!-- code[ruby] -->

    ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => 8888);\
      s.mount('/',WEBrick::HTTPServlet::FileHandler, './'); \
      trap('INT'){ s.shutdown }; \
      s.start"

For once I prefer the [python
way](http://ebarnouflant.com/post/11646387716/one-liner-to-start-a-local-http-server).
