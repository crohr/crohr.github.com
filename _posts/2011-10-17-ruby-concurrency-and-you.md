---
title: Ruby, Concurrency, and You
layout: post

type: regular
---

<a href="http://www.engineyard.com/blog/2011/ruby-concurrency-and-you/">Ruby, Concurrency, and You</a>

> That about sums up the situation with MRI 1.8 and 1.9 with regards to concurrency and parallelism. Both provide concurrency of Ruby code, but neither provide parallelism of Ruby code.

Bad for CPU-bound processes, but do we really care for IO-bound processes?

> MRI 1.9 uses the same technique as MRI 1.8 to improve the situation, namely the GIL is released if a Thread is waiting on an external event (normally IO) which improves responsiveness. 