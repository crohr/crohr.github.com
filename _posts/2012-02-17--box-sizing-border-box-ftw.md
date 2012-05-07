---
title: "* { box-sizing: border-box } FTW"
layout: post
tags:
  - css

type: link
---

<a href="http://paulirish.com/2012/box-sizing-border-box-ftw/">* { box-sizing: border-box } FTW</a>

[Paul Irish](http://paulirish.com/2012/box-sizing-border-box-ftw/):

> One of my least favorite parts about layout with CSS is the relationship of width and padding. You're busy defining widths to match your grid or general column proportions, then down the line you start to add in text, which necessitates defining padding for those boxes. And 'lo and behold, you now are subtracting pixels from your original width so the box doesn't expand.

Enter `box-sizing` CSS property:

<!-- code[css] -->

    /* apply a natural box layout model to all elements */
    * { -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }

Didn't know about that one. It's safe to use according to <http://html5please.us/#box-sizing>.

