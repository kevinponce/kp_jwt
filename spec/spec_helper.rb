# frozen_string_literal: true

require 'rubygems'
require 'spork'
require 'bundler/setup'
require 'rails/all'
require 'webmock/rspec'
require 'database_cleaner'
require 'simplecov'

# uncomment the following line to use spork with the debugger
# require 'spork/ext/ruby-debug'

Spork.prefork do
  RSpec.configure do |config|
    config.mock_with :rspec
    config.order = 'random'
    # Enable flags like --only-failures and --next-failure
    config.example_status_persistence_file_path = '.rspec_status'

    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end
