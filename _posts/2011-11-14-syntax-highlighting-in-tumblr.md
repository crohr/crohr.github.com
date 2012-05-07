---
title: Syntax highlighting in Tumblr
layout: post
tags:
  - code
  - syntax highlighting

type: regular
---

There are multiple solutions to add syntax highlighting for code blocks in Tumblr articles written with Markdown, but they all demand to manually put `<pre>`, `<code>` tags and `class` attributes in the text. You can find the references here: 

* <http://drnicwilliams.com/2007/03/08/syntax-highlighting-in-tumblr/>
* <http://alan.dipert.org/post/55814908/shjs-javascript-syntax-highlighting-for-tumblr>
* <http://snippets-of-code.tumblr.com/post/6027484416/adding-syntax-highlighting-into-tumblr>

This is too much pollution for me, so I came up with a simple HTML comment to put before code blocks you want to highlight. I then use a small bit of Javascript to extract that info and automatically update the class of the `<code>` tag. Associated with [Highlight.js](http://softwaremaniacs.org/soft/highlight/en/), this gives nice syntax highlighting in just one line. For example, the following Markdown snippet:

<!-- code[no-highlight] -->

    <!-- code[ruby] -->
  
        puts "This is Ruby code"


Will give:

<!-- code[ruby] -->

    puts "This is Ruby code"

Note that most of the time, you don't even need to specify the language, since Highlight.js will often detect the right brush for you. Also, HTML comments won't show up in your RSS feed.

To enable this feature, open the 'customize appearance' link in your Tumblr dashboard, then click on 'Edit HTML', and enter the following code just before the opening `<body>` tag (you might need to include the [jQuery](http://code.google.com/apis/libraries/devguide.html#jquery) library if you don't already have it):

<!-- code[html] -->

    <link rel="stylesheet" 
          href="http://yandex.st/highlightjs/6.1/styles/zenburn.min.css">
    <style>
      code {
        font-family: monospace;
        overflow: auto;
      }
    </style>
    
    <script src='http://yandex.st/highlightjs/6.1/highlight.min.js'></script>
    <script type="text/javascript">
      $(document).ready(function() {
        var codeCommentRegexp = /code\[(.+)\]/;
        var match;
        $("pre").parent().contents().filter(function(){
            return this.nodeType == 8;
        }).each(function(i, e){
          if (match=codeCommentRegexp.exec(e.nodeValue)) {
            try{
              $(e).nextAll("pre").first().
                find("code").addClass(match[1]);
            } catch(e) {}
          }
        });
        hljs.tabReplace = '  ';
        hljs.initHighlightingOnLoad();
      });
    </script>

Enjoy!
