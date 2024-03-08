# frozen_string_literal: true

ruby file: '.ruby-version'

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'bundler', require: false
  # Source prism from GitHub for unreleased fixes, e.g. https://github.com/ruby/prism/pull/ 2563 .
  gem 'prism', github: 'ruby/prism', require: false
  gem 'pry'
  gem 'pry-byebug'
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
