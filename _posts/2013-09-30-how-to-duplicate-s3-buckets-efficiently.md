---
title: How to duplicate S3 buckets efficiently
layout: post
tags:
  - s3
  - devops
---

Let's say you want to duplicate a fairly large S3 bucket (for instance you want to make sure your staging bucket is in sync with your production bucket), but doing so with s3cmd takes forever, as well as going through the console UI (see [this stackoverflow post](http://stackoverflow.com/questions/4663016/faster-s3-bucket-duplication)).

Solution: use [s3s3mirror](https://github.com/cobbzilla/s3s3mirror), which is a highly concurrent tool targeted at just this exact use case. Note that it won't copy the object if it already exists and has the same ETag, and it also copies the object metadata and ACL lists. Perfect!
