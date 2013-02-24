task :deploy do
  sh "git push origin source && bundle exec jekyll --no-server --no-lsi --no-auto && git checkout master && cp -r _site/* . && git add . && git commit -am 'Update static files.' && git push origin master && git checkout source"
end

desc "Generates a new ebarnouflant post"
task :ebarnouflant do
  id = "%03d" % (Dir["./_posts/*-ebarnouflant-*.md"].sort.last.gsub(/.*-ebarnouflant-(\d+)\.md/, '\1').to_i + 1)
  filename = Time.now.strftime("%Y-%m-%d-ebarbouflant-#{id}.md")
  File.open("./_posts/#{filename}", "w+") do |f|
    f.puts "---"
    f.puts "title: \"Ebarnouflant ##{id}\""
    f.puts "layout: post"
    f.puts "tags:"
    f.puts "  - ebarnouflant"
    f.puts "---"
    f.puts
    f.puts `FROM="#{ENV.fetch('FROM')}" ebarnouflant`
  end
end