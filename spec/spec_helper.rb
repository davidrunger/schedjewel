# frozen_string_literal: true

require 'simplecov'
if ENV.fetch('CI', nil) == 'true'
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
  SimpleCov.coverage_dir('tmp/simple_cov') # must match codecov-action directory option
elsif RSpec.configuration.files_to_run.one?
  require 'simple_cov/formatter/terminal'
  SimpleCov.formatter = SimpleCov::Formatter::Terminal
end
SimpleCov.start do
  add_filter(%r{\A/spec/})
end

require 'bundler/setup'
Bundler.require(:default, :test)

require_relative '../lib/schedjewel.rb'

Dir['spec/support/**/*.rb'].each { |file| require("./#{file}") }
require 'active_support'
require 'active_support/testing/time_helpers'
require 'active_support/isolated_execution_state' # required for `#travel_to`

RSpec.configure do |config|
  config.include(SpecHelpers)
  config.include(ActiveSupport::Testing::TimeHelpers)

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.filter_run_when_matching(:focus)

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    # Some of the specs involve somewhat lengthy strings; increase the size of the printed output
    # for easier comparison of expected vs actual strings, in the event of a failure.
    # https://github.com/rspec/rspec-expectations/issues/ 991#issuecomment-302863645
    RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = 2_000

    Schedjewel.logger.level = Logger::WARN # don't print output to console when running tests
  end

  config.before(:each) do
    stub_config_file_content
    Schedjewel.app_redis.with { _1.call('flushdb') }
    Schedjewel.sidekiq_redis.with { _1.call('flushdb') }
  end

  config.around(:each, :frozen_time) do |spec|
    freeze_time
    spec.run
    travel_back
  end
end
