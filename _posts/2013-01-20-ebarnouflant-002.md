---
title: "Ebarnouflant #002"
layout: post
tags:
  - ebarnouflant

---

Back from the [TakeOff](http://takeoffconf.com/) conference in Lille,
France. Great people, some really good talks, and a lot to think about.

* [Squash: The open-source bug-smashing tool](http://squash.io/) - Exception reporting and bug analysis tool from Square. Requires that your project be stored in a git repo.
* [Unix shell initialization](https://github.com/sstephenson/rbenv/wiki/Unix-shell-initialization) - Ever wondered which initialization files get sourced by your shell depending on how it is run? Good reference page from the rbenv wiki.
* [Singletons, Threads, and Flexibility](http://www.bleonard.com/blog/2013/01/18/singletons/) - A take on how to make thread-safe Ruby libraries that use a module or class level singleton for configuration/execution.
* [Talks To Help You Become A Better Front-End Engineer In 2013](http://www.smashingmagazine.com/2012/12/22/talks-to-help-you-become-a-better-front-end-engineer-in-2013/) - That's a lot of them, but pick the topics that most interest you.
* [AMD is Not the Answer](http://tomdale.net/2012/01/amd-is-not-the-answer/) - Wanting to look at RequireJS to manage your javascript dependencies? Here is a rant by Tom Dale (creator of Ember.js) explaining why this is not a good solution in modern apps.
* [AMD is better for the web than CommonJS modules](http://blog.millermedeiros.com/amd-is-better-for-the-web-than-commonjs-modules/) - Counterpoint to the "AMD is Not the Answer" article.
* [Which one of angular.js and ember.js is the better choice?](http://www.quora.com/Ember-js/Which-one-of-angular-js-and-ember-js-is-the-better-choice) - Good question indeed.
* [RequireJS](http://requirejs.org/) - If you want to know more about RequireJS, a JavaScript file and module loader.
* [HeadJS, the only script in your HEAD](http://headjs.com/) - That's a lot of Javascript frameworks and loaders for a single edition, but yet another one.
* [rwldrn/johnny-five](https://github.com/rwldrn/johnny-five) - JavaScript Arduino programming framework. We had a demonstration at the TakeOffConf, and it looks very easy to use.
* [Google Identity Toolkit](https://developers.google.com/identity-toolkit/) - Free toolkit for websites who currently allow users to login with their email address and password, and would like to replace that password with federated login. Currently supports Google mail, Hotmail, Yahoo! mail, AOL mail, and Google Apps mail.
* [12 steps to win at software development](http://courseware.codeschool.com/uploads/12_steps_takeoffconf.pdf) - Nice talk by Greg Pollack, given at TakeOffConf. Direct link to the PDF.
* [Lipstick on a pig](http://pekelman.com/presentations/apidays/#/1/28) - Don't try to piggyback a REST API on your legacy SOAP web services just by using JSON and HTTP methods. This requires design, or you'll likely end up with an API that has the same beauty as what could be achieved by putting lipstick on a pig.
* [Put chubby models on a diet with concerns](http://37signals.com/svn/posts/3372-put-chubby-models-on-a-diet-with-concerns?47#all_comments) - Nice quote by DHH in the comments of this article: "Rails itself is designed exclusively with the 'good, responsible, trusted developers' in mind. If it happens to work for “bad, irresponsible, untrustworthy developers” as well, that’s merely an inconsequential side effect. There are lots of development environments that focus explicitly on preventing that later group from doing much damage. Ruby on Rails was never intended to be among those."
* [Rands In Repose: The Process Myth](http://www.randsinrepose.com/archives/2013/01/01/the_process_myth.html) - "On the list of ways to generate a guaranteed negative knee-jerk reaction from an engineer, I offer a single word: process."
* [Amanda Cox and Countrymen](http://amandacox.tumblr.com/) - Visualizations blog by one of the best in the field.
* [jonrohan/ZeroClipboard](https://github.com/jonrohan/ZeroClipboard) - Javascript library to copy text to the clipboard. By github.
* [The 10 commandments of logging](http://www.masterzen.fr/2013/01/13/the-10-commandments-of-logging/) - TL;DR : write meaningful and parseable logs, at the right level, using a proper library.
* [Virtualization Performance: Zones, KVM, Xen](http://dtrace.org/blogs/brendan/2013/01/11/virtualization-performance-zones-kvm-xen/) - Summary of the performance of various virtualization technologies (Zones, KVM, Xen) by Joyent.
* [Cut down some seconds of your spec suite by removing database_cleaner](https://coderwall.com/p/ivvntg) - Code snippet to only truncate your database tables on examples that really need it.
* [find ~/ -size +100M -exec du -h {} ;](https://twitter.com/climagic/status/289737218795376641) - Find all files larger than 100MB and display their human readable size.
* [vertiginous/pik](https://github.com/vertiginous/pik) - Ruby version manager for Windows.