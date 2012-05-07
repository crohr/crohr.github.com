---
title: How to get a major speedup on all OpenNebula command-line and OCCI tools
layout: post
tags:
  - opennebula
  - code
  - occi

type: regular
---

Long version is at http://dev.opennebula.org/issues/1017.

Short version is: switch to a Nokogiri based XML Stream parser for the XMLRPC
client, instead of the (really) slow REXML based stream parser used by
default. Then the ONE tools that make XML-RPC requests (i.e. almost all of
them, including the OCCI server) will be a __hundred times faster__.

This is especially useful when you start to have more than 100 VMs running, since you're not required to wait for more than 1 minute (!)
for your `onevm list` or `onevm top` to display. These commands are now
running in less than 1 second at our local installation.

The patch is really simple (to be applied to the `OpenNebula.rb` file, tested
with OpenNebula 3.0.0):

<!-- code[diff] -->

    85a86,92
    >         NOKOGIRI_PARSER = begin
    >             require 'stream_parser_mixin'
    >             true
    >         rescue LoadError
    >             false
    >         end
    > 
    132c139,141
    <             if XMLPARSER
    ---
    >             if NOKOGIRI_PARSER
    >                 @server.set_parser(XMLRPC::XMLParser::NokogiriStreamParser.new)
    >             elsif XMLPARSER
    134a144
    >

You can get everything up and running with:

<!-- code[bash] -->

    $ gem install xmlrpc-streaming nokogiri && \
    curl http://flag.io/33998d87be6c9f8f3a6b0ae72c65fbb9 | patch /usr/lib/one/ruby/OpenNebula.rb -

__UPDATE__: looks like you can get similar performance boost by installing the `xmlparser` Ruby gem, which uses the Expat XML parsing library (see this [doc](http://opennebula.org/documentation:rel3.0:ignc#ruby_libraries_requirements_front-end)) and is already supported by OpenNebula for Ruby < 1.9.
