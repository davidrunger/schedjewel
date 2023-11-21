# frozen_string_literal: true

ruby File.read('.ruby-version').rstrip
source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'bundler', require: false
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
