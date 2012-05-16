require 'rubygems'
require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "taskmapper-bitbucket"
  gem.summary = %Q{The bitbucket provider for taskmapper}
  gem.description = %Q{This provides an interface with bitbucket through the taskmapper gem.}
  gem.email = "george.rafael@gmail.com"
  gem.homepage = "http://github.com/hybridgroup/taskmapper-bitbucket"
  gem.authors = ["HybridGroup"]
end
Jeweler::GemcutterTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
