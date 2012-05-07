---
title: One-liner to pretty print a JSON output on the command line
layout: post
tags:
  - python
  - json
  - one-liner

type: regular
---

As a reminder, here is how you would pretty print a JSON output on the command line, with no additional dependencies except Python, which is most of the time available everywhere:

     curl -s 'http://twitter.com/users/crohr.json' | python -mjson.tool
