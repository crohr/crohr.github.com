---
layout: page
title: Cyril Rohr - CV / About me
tab: about
---

Freelance developer, specializing in distributed RESTful architectures, APIs, Ruby & Node.js development (both frontend and backend), and DevOps consulting. I can make your software development process more reliable, and improve your tooling to deliver high quality software. You can see my recommendations on LinkedIn (<http://www.linkedin.com/in/cyrilrohr>), and my open-source contributions on Github (<https://github.com/crohr>).

Tel: +44 (0) 7527 469431 | Address: Leamington Spa, UK.
<br/>
Website: <http://crohr.me> | Email: <contact@crohr.me> | Skype: cyril.rohr

## Work Experience

* Since 2012: Working as a Ruby & Rails freelance developer, and doing DevOps consulting. Clients include:

    * **NowFashion** - Finished/Restarted the development of central features of the website (Rails4) in two weeks, in time for the Fashion Week events, after it was delayed for more than a year by an outsourced team. Real-time updates (WebSockets / Pusher), simplified administration (ActiveAdmin), batch upload and photo processing (Sidekiq), hosted on Amazon EC2 and S3.

    * **Dexem SA** (8 months) - Designed and implementated new features for the company's RubyOnRails projects. Improved the development process of the team: new bug tracker, switch from SVN to Git, addition of unit, integration, and acceptance tests to the main application (IVR management), installation of a Jenkins server for continuous integration and deployment. Migration of
legacy Rails apps (Rails2.0.2, Ruby1.8.6) to more recent versions of Rails and Ruby. *Ruby 1.8.6/1.8.7/1.9.3, Rails 2.0.2/2.3.x/3.x, MySQL, jQuery, Bootstrap, RSpec, Capybara, Selenium, Vagrant, Puppet, Jenkins*.

    * **ReverbHQ** (3 months) - Consulting work for various clients of the Agency. Developed a shopping website for one of the main school photographers in Canada (thousands of clients). *Ruby, Rails 3.x, PostgreSQL, jQuery, Resque, ImageMagick*.

    * **Dimelo SA** (1.5 month) - Implemented the Badgeville gamification features for an in-house CRM tool, comprising of three different interconnected apps. *Ruby, Rails 2.3.x, MySQL, jQuery, Badgeville API*.

    * **Groupe ACP** - 2 weeks training of a technical drawer to use the [Sketch'Up Ruby API](http://www.sketchup.com/intl/en/developer/) to automate common tasks in construction design.

* 2008-2012: Research engineer at **Inria** (<http://www.inria.fr>) in Rennes,
France.

    Led the work on RESTful API design, User Interface design (*jQuery*, *jQuery
Mobile*, *d3.js*), Core Ruby backends (*RubyOnRails/Sinatra*), user monitoring, identity management and federation (LDAP), and client tool
developments for Grid'5000 and BonFIRE cloud APIs. Also contributed major parts of
the user and technical documentation. Grid'5000 is the leading research platform in
parallel and distributed systems in France and Europe. BonFIRE is a European
project aimed at building a federation of cloud computing providers over
Europe. <br><br>You can see screencasts of my work at <https://vimeo.com/36507035> and <https://vimeo.com/39257324>.

* 2008: Six-months research project at the **Queensland University of
  Technology** in Brisbane, Australia.

    Worked on cross-media summarization and video processing. Built a working
prototype of a news aggregation engine (text, images, videos) in RubyOnRails, and
participated in the TrecVID (<http://trecvid.nist.gov/>) challenge, devoted
to research in automatic segmentation, indexing, and content-based retrieval
of digital video. Published two articles.

<!--
* 2007: Three-months internship as a software developer at the Kalistick
  startup (<http://kalistick.fr>) in Lyon, France. Helped building a
  software to drive quality and best practices in Java software
  developments using code analyzers, rules engines, and business
  intelligence tools.

* 2006: Two-months internship as a developer in a small business in
  Lyon, France. Built a customer management and invoicing tool in
  PHP/MySQL/HTML.
-->

## Education

* 2008: Received a MSc in Computer Science with high honours from the
  *Institut National des Sciences Appliquées* (<http://insa-lyon.fr/>)
  in Lyon, France. Final year of education at the *Queensland University
  of Technology* (<http://qut.edu.au>) in Brisbane, Australia.

## Main skills

* Programming languages: Ruby, Javascript (CoffeeScript, Node.js), Java, PHP.
* Backend: Ruby on Rails (2.x,3.x,4.x), Express.js.
* Frontend: HTML, CSS (SASS, SCSS), jQuery (jQuery-UI, jQuery-Mobile).
* Databases: MySQL, LDAP, Redis, CouchDB, Sqlite, Postgres.
* Deployment & Configuration: Puppet, Capistrano, Debian packaging.
* Testing: RSpec, Capybara, Selenium.
* Cloud computing: Amazon Web Services (EC2, S3, ElasticLoadBalancing), Heroku, OpenNebula.
* Monitoring: Ganglia, Zabbix.
* HTTP & related: Apache, NginX, HAProxy, Squid, Public key infrastructures, OAuth.
* UNIX/GNU Linux: bash, SSH, vim, Git, SVN.
* Machine learning: clustering, classification, rules engines.

I can speak and write French (native), and English (fluent).

## Publications

I had a brief but fulfilling research experience during the last 6 months of
my education. Below are some of the articles I (co)-authored:

* Eugen Feller, **Cyril Rohr**, David Margery, and Christine Morin.
  *Energy Management in IaaS Clouds: A Holistic Approach*. The 5th IEEE
  International Conference on Cloud Computing (CLOUD), Honolulu, Hawaii,
  USA, June 2012.

* **Cyril Rohr** and Dian Tjondronegoro. 2008. Aggregated cross-media
  news visualization and personalization. In Proceeding of the 1st ACM
  international conference on Multimedia information retrieval (MIR
  '08). ACM, New York, NY, USA, 371-378.

* Johannes Sasongko, **Cyril Rohr**, and Dian Tjondronegoro. 2008.
  Efficient generation of pleasant video summaries. In Proceedings of
  the 2nd ACM TRECVid Video Summarization Workshop (TVS '08). ACM, New
  York, NY, USA, 119-123.

## Other interests

* Chess player. Juggler. Loves skiing & reading.

* Side-projects: <https://pkgr.io> (RubyOnRails, docker), <http://chunk.io> (Node.js).

## Code

Here is some software I've written in my spare time or that my previous
employers allowed me to publicly release.

* [pkgr] [pkgr] - Easily package your Rails app into deb or rpm packages.
  After a few months of dealing with the various intricacies of packaging Ruby
  apps for debian or centos, here is a gem that does everything for you.

* [restfully] [restfully] - A Ruby client for RESTful APIs.

* [rest-client-components] [components] - [Rack] [rack] should not be limited
  to HTTP servers, it's also a very good client-side abstraction for pluggable
  middleware!

* [g5k-campaign] [g5k-campaign] - A tool to launch experiment campaigns on
  [Grid'5000] [grid5000], based on the concept of extensible campaign engines.

* [syslogger] [syslogger] - Finally a proper `syslog` library for Ruby. Can be
  used as a drop-in replacement for the standard `Logger` library.

* [toggl-notifier] [toggl-notifier] - Hack! Update your Adium status with the
  description of your current task in [Toggl](http://toggl.com) (Mac only).

[pkgr]: http://crohr.me/pkgr/
[restfully]: http://crohr.me/restfully/
[components]: http://github.com/crohr/rest-client-components
[rack]: http://rack.rubyforge.com
[g5k-campaign]: http://g5k-campaign.gforge.inria.fr/
[grid5000]: http://www.grid5000.fr/
[syslogger]: http://github.com/crohr/syslogger
[toggl-notifier]: http://github.com/crohr/toggl-notifier

You can find more on my Github account: <a href="http://github.com/crohr"
target="_blank">http://github.com/crohr</a>.
