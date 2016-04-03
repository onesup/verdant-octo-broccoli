ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/autorun"
require "active_support/testing/setup_and_teardown"
require "capybara/rails"

# RubyMine requires this gem.
# require "minitest/reporters"
# Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

# require 'sidekiq/testing'
# Sidekiq::Testing.fake!

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include FactoryGirl::Syntax::Methods

  before :each do
    DatabaseCleaner.start
    Rails.application.load_seed
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
  register_spec_type(/integration/, self)
  Capybara.asset_host = "http://localhost:3000"
end
