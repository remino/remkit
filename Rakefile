require 'rake'

desc 'Build the Jekyll site'
task :build do
	sh 'bundle exec jekyll build'
end

desc 'Serve the Jekyll site with live reload'
task :serve do
	sh 'bundle exec jekyll serve --livereload --incremental'
end

task default: :build
