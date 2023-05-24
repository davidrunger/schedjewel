# frozen_string_literal: true

ruby '3.2.0'

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in schedjewel.gemspec
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
  gem 'simple_cov-formatter-terminal'
end
