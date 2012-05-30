task :deploy do
  sh "git push origin source && bundle exec jekyll --no-server --no-lsi --no-auto && git checkout master && cp -r _site/* . && git add . && git commit -am 'Update static files.' && git push origin master && git checkout source"
end