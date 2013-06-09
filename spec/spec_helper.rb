require 'active_record'
require 'time_hen'
require 'sqlite3'
require 'database_cleaner'

require "author_stubs"

FIXTURES_DIR = File.expand_path './fixtures', File.dirname(__FILE__)



RSpec.configure do |config|
  config.filter_run_excluding :skip => true
  config.formatter = :documentation # :progress, :html, :textmate
  config.fail_fast = true


  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end



