# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'dummy/config/environment'
require 'rspec/rails'
require 'timecop'
require 'database_cleaner'
require 'spec_helper'
require 'simplecov'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir["#{File.dirname(__FILE__)}/support/{dependencies,helpers,shared}/*.rb"].each { |f| require f }
