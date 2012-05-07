---
title: The Open Cloud Computing Interface
layout: post
tags:
  - occi
  - opinions

type: regular
---

<img src="http://media.tumblr.com/tumblr_lt1pzuz1BG1r1c5kq.png" style="float:right; width: 50%;">
The people behind the OCCI working group are trying to define a standard for
cloud computing. The OCCI spec went from being an Infrastructure as a Service
specification (i.e. how to represent compute, network, and storage resources)
to a "Protocol and API for all kinds of Management tasks". The quote below is taken from the [OCCI website](http://occi-wg.org/):

> OCCI was originally initiated to create a remote management API for IaaS
model based Services, allowing for the development of interoperable tools for
common tasks including deployment, autonomic scaling and monitoring. It has
since evolved into a flexible API with a strong focus on **integration**,
**portability**, **interoperability** and **innovation** while still offering
a high degree of extensibility. The current release of the Open Cloud
Computing Interface is suitable to serve many other models in addition to
**IaaS**, including e.g. **PaaS** and **SaaS**.

Well, buzzwords everywhere! 

I admire the work to propose a standardized *protocol* for managing things,
but I think it needs a lot more work to make it usable and understandable.
They basically went from a simple to understand data model to a fully
extensible one, which allows *everything* to be described (with the *Resource*
entity), categorized (*Mixin*, *Kind* concepts), interlinked (*Link* entity),
and managed (*Action*). The [OCCI Core spec][core_spec] is unclear in many
aspects, and the proposed [RESTful HTTP Rendering spec][rendering_spec] is not
good as it is now (my thoughts [here][occi_thoughts]).

[core_spec]: http://ogf.org/documents/GFD.183.pdf
[rendering_spec]: http://ogf.org/documents/GFD.185.pdf
[occi_thoughts]: http://www.ogf.org/pipermail/occi-wg/2011-July/002611.html

There is, however, the [OCCI Infrastructure spec][infrastructure_spec], which
as far as I can see is an instance of the OCCI Core spec targeted at IaaS
providers (the original target of OCCI efforts). The spec is clear (most
probably because it manipulates well understood concepts), but implementation
is still dependent of the HTTP Rendering spec, which leads to inconsistent
and/or broken implementations between IaaS providers.

[infrastructure_spec]: http://ogf.org/documents/GFD.184.pdf

Hopefully, that will change in the future with additions to the spec, testing
tools to check the conformance of implementations, and more reference examples
in major IaaS providers ([OpenNebula][opennebula] for example).

[opennebula]: http://opennebula.org/

