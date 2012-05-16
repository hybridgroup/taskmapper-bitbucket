$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'taskmapper'
require 'taskmapper-bitbucket'
require 'spec'
require 'spec/autorun'
require 'factory_girl'

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f }

Spec::Runner.configure do |config|
end
