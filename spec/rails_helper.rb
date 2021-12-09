require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'ffaker'
require 'support/factory_bot'
require 'support/spec_loader'
require 'devise'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers

  # Capybara.default_driver = :selenium_chrome
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
