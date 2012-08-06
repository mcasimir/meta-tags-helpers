# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "meta-tags-helpers"
  gem.homepage = "http://github.com/mcasimir/kaminari-bootstrap"
  gem.license = "MIT"
  gem.summary = %Q{Rails meta tags helpers}
  gem.description = %Q{Rails meta tags helpers}
  gem.email = "maurizio.cas@gmail.com"
  gem.authors = ["mcasimir"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


task :push do
  message = ENV["message"] || "commit #{Time.now}"
  `git add . && git commit -a -m '#{message}' && git push`
end

task "release:patch" do
  Rake::Task["gemspec"].invoke
  Rake::Task["version:bump:patch"]
  Rake::Task["push"].invoke
  Rake::Task["release"].invoke  
end

task "release:minor" do
  Rake::Task["gemspec"].invoke
  Rake::Task["version:bump:minor"]
  Rake::Task["push"].invoke
  Rake::Task["release"].invoke  
end

task "release:major" do
  Rake::Task["gemspec"].invoke
  Rake::Task["version:bump:major"]
  Rake::Task["push"].invoke
  Rake::Task["release"].invoke  
end