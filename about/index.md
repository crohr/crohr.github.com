---
layout: page
title: About me
tab: about
---

{% include about.md %}

## Work Experience

### Freelance

Working independently since April 2012.

### INRIA - National Research Institute

From Oct. 2008 to Mar. 2012, I worked as a R&amp;D Engineer at the
[INRIA](http://www.inria.fr/) national research institute in Rennes, France.

I originally started to work on the [Grid'5000](http://www.grid5000.fr/)
project, an infrastructure distributed in 9 sites around France for research
in large-scale parallel and distributed systems. In Aug. 2010 I also joined
the EU founded [BonFIRE](http://bonfire-project.eu/) project to work on a
multi-site cloud facility.

I was mainly in charge of designing, implementing and operating a distributed
software architecture based on RESTful APIs. I also built web interfaces and
visualizations using standard and lightweight technologies such as HTML5,
Javascript, CSS.

My day-to-day work usually involved me writing code using a mix of Ruby,
Javascript, HTML and CSS; pushing and pulling with Git; messing with DEB and
RPM packages; cooking some Puppet recipes to configure and deploy two dozens
of servers; and trying to bend big-old Apache and Squid to my will.

### Queensland University of Technology

From Jan. to Jul. 2008, I was a Research Intern at the [Queensland Institute
of Technology](http://qut.edu.au/) in Brisbane, Australia, where I worked on
Cross-Media summarization and Video processing.

My research project consisted in designing and building a solution to crawl,
index and process media content (text, videos and images) from hundreds of
online news sources to provide an aggregated view of the day-to-day news
information flow. A (then) innovative browser-based interface was also built
for browsing and filtering the resulting news events (see
[Publications](#publications)).

I also participated in the international [TRECVid](http://trecvid.nist.gov/)
workshop sponsored by the National Institute of Standards and Technology
([NIST](http://www.nist.gov/)), devoted to research in automatic segmentation,
indexing, and content-based retrieval of digital video (see
[Publications](#publications)).

### Kalistick - Startup

In 2007, I worked for 3 months as a Software Engineer Intern for the
[Kalistick](http://kalistick.com/) startup (*Agile quality for continuous
delivery*) in Lyon, France.

This internship brought me a lot of knowledge about software quality, testing,
and best-practices. I mainly worked with Java, code analyzers, rules engines
and business intelligence tools.

### Les Bains de l'Opéra - Small business

In 2006, I worked for 2 months as a Software Developer Intern for [Les Bains
de l'Opéra](http://lesbainsdelopera.com/) in Lyon, France, where I developed a
web intranet application to replace their invoicing and customer management
tool. At that time, I mainly worked with PHP5, HTML and what was called AJAX.

## Education

In 2008, I obtained my MSc in Computer Science with high honours from the
*Institut National des Sciences Appliquées* ([INSA] [insa]), a French
engineering [*Grande École*] [grande-ecole] in Lyon, France.

I had a great time doing my final year of education and a bit of research at
the *Queensland University of Technology* ([QUT] [qut]) in Brisbane,
Australia.

[insa]: http://www.insa-lyon.fr/
[grande-ecole]: http://en.wikipedia.org/wiki/Grandes_%C3%A9coles
[qut]: http://qut.edu.au

## Publications

I had a brief but fulfilling research experience during the last 6 months of
my education. Below are the two articles I (co)-authored:

* **Cyril Rohr** and Dian Tjondronegoro. 2008. [*Aggregated cross-media news
  visualization and
  personalization*](http://portal.acm.org/citation.cfm?id=1460157). In
  Proceeding of the 1st ACM international conference on Multimedia information
  retrieval (MIR '08). ACM, New York, NY, USA, 371-378.

* Johannes Sasongko, **Cyril Rohr**, and Dian Tjondronegoro. 2008. [*Efficient
  generation of pleasant video
  summaries*](http://portal.acm.org/citation.cfm?id=1463563.1463585). In
  Proceedings of the 2nd ACM TRECVid Video Summarization Workshop (TVS '08).
  ACM, New York, NY, USA, 119-123.

And below is an article I co-authored while at Inria:

* Eugen Feller, **Cyril Rohr**, David Margery, and Christine Morin. *Energy
  Management in IaaS Clouds: A Holistic Approach*. The 5th IEEE International
  Conference on Cloud Computing (CLOUD), Honolulu, Hawaii, USA, June 2012.
  
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

You can find more on my <a href="http://github.com/crohr"
target="_blank">Github account</a>.
