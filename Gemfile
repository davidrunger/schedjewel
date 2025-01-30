# frozen_string_literal: true

ruby file: '.ruby-version'

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'bundler', require: false
  # Remove if/when byebug brings in this dependency for us.
  gem 'irb'
  gem 'pry'
  # Go back to upstream if/when https://github.com/deivid-rodriguez/pry-byebug/pull/ 428 is merged.
  gem 'pry-byebug', github: 'davidrunger/pry-byebug'
  # Remove if/when byebug brings in this dependency for us.
  gem 'reline'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'runger_style', require: false
end

group :test do
  gem 'activesupport', require: false
  gem 'rspec', require: false
  gem 'simplecov'
  gem 'simplecov-cobertura', require: false
  gem 'simple_cov-formatter-terminal', require: false
end

group :development do
  gem 'runger_release_assistant', require: false
end
