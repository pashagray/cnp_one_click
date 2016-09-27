# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cnp_one_click'
require 'capybara'
require 'capybara/rspec'
require 'webmock/rspec'
require 'support/stub_helpers'
Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include StubHelpers
end