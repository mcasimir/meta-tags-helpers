require 'rubygems'
require 'bundler/setup'

require 'combustion'

Combustion.initialize! :all

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
