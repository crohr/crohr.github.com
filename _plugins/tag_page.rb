# desc 'Generate tags pages'
# task :tags  => :tag_cloud do
#   puts "Generating tags..."
#   require 'rubygems'
#   require 'jekyll'
#   include Jekyll::Filters
# 
#   options = Jekyll.configuration({})
#   site = Jekyll::Site.new(options)
#   site.read_posts('')
# 
#   # Remove tags directory before regenerating
#   FileUtils.rm_rf("tags")
# 
#   site.tags.sort.each do |tag, posts|
#     html = <<-HTML
# ---
# layout: default
# title: "tagged: #{tag}"
# syntax-highlighting: yes
# ---
#   <h1 class="title">#{tag}</h1>
# 
#    {% for post in site.posts %}
#        {% for tag in post.tags %}
#            {% if tag == '#[tag]'%}
#                {% include post.html %}
#            {% endif %}
#        {% endfor %}
#    {% endfor %}
# HTML
# 
#     FileUtils.mkdir_p("tags/#{tag}")
#     File.open("tags/#{tag}/index.html", 'w+') do |file|
#       file.puts html
#     end
#   end
#   puts 'Done.'
# end

# Copyright (C) 2011 Anurag Priyam - MIT License

module Jekyll

  # Jekyll plugin to generate tag clouds.
  #
  # The plugin defines a `tag_cloud` tag that is rendered by Liquid into a tag
  # cloud:
  #
  #     <div class='cloud'>
  #         {% tag_cloud %}
  #     </div>
  #
  # The tag cloud itself is a collection of anchor tags, styled dynamically
  # with the `font-size` CSS property. The range of values, and unit to use for
  # `font-size` can be specified with a very simple syntax:
  #
  #     {% tag_cloud font-size: 16 - 28px %}
  #
  # The output is automatically formatted to use the same number of decimal
  # places as used in the argument:
  #
  #     {% tag_cloud font-size: 0.8  - 1.8em  %}  # => 1
  #     {% tag_cloud font-size: 0.80 - 1.80em %}  # => 2
  #
  # Tags that have been used less than a certain number of times can be
  # filtered out from the tag cloud with the optional `threshold` parameter:
  #
  #     {% tag_cloud threshold: 2%}
  #
  # Both the parameters can be easily clubbed together:
  #
  #     {% tag_cloud font-size: 50 - 150%, threshold: 2%}
  #
  # The plugin randomizes the order of tags every time the cloud is generated.
  class TagPage < Liquid::Tag
    safe = true

    # tag cloud variables - these are setup in `initialize`
    attr_reader :size_min, :size_max, :precision, :unit, :threshold

    def initialize(name, params, tokens)
      # initialize default values
      @size_min, @size_max, @precision, @unit = 70, 170, 0, '%'
      @threshold                              = 1

      # process parameters
      @params = Hash[*params.split(/(?:: *)|(?:, *)/)]
      super
    end

    def render(context)
      html = ""

      tags = context.registers[:site].tags.sort_by{|name, posts| name}.each do |(name, posts)|
        next if posts.count < threshold
        html << "<h2 id='#{name}'>#{name} (#{posts.count})</h2>"
        html << "<ul class='posts'>"
        posts.each do |post|
          html << "<li><a href='#{post.url}'>#{post.data["title"]}</a></li>"
        end
        html << "</ul>"
      end

      html
    end

  end
end

Liquid::Template.register_tag('tag_page', Jekyll::TagPage)