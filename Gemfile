# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem 'rails', '~> 7.0.0'

group :development, :test do
  gem 'autoprefixer-rails', '~> 8.1.0'
  gem 'byebug',             '~> 10.0.0', platforms: %i[mri mingw x64_mingw]
  gem 'capybara',           '~> 3.39.0'
  gem 'image_processing',   '>= 1.2'
  gem 'kaminari',           '~> 1.2', '>= 1.2.2'
  gem 'selenium-webdriver', '~> 4.9.0'
  gem 'sqlite3',            '~> 1.4.2'
end

group :development do
  gem 'listen',       '~> 3.8.0'
  gem 'web-console',  '~> 4.2'
end

group :test do
  gem 'brakeman',                 '~> 5.4.1'
  gem 'bundler-audit',            '~> 0.9.1'
  gem 'coveralls_reborn',         '~> 0.28.0', require: false
  gem 'diffy',                    '~> 3.4.2'
  gem 'equivalent-xml',           '~> 0.6.0'
  gem 'minitest',                 '~> 5.20.0'
  gem 'minitest-reporters',       '~> 1.6.1'
  gem 'mocha',                    '~> 2.1.0', require: false
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rubocop',                  '~> 1.56.0', require: false
  gem 'simplecov',                '~> 0.22.0', require: false
end
