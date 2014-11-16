source 'http://rubygems.org'

ruby '2.1.5'
gem 'rails', '4.1.7'

gem 'bootstrap-sass', '~> 3.1.1'
gem 'faker'
gem 'figaro'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'scheduler_daemon', :git => 'git://github.com/ssoroka/scheduler_daemon.git'
gem 'simple_form'
gem 'sqlite3'
gem 'sprockets', '=2.11.0'
gem 'twitter'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails', '>= 3.2'
  gem 'uglifier'
end

group :development , :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails' , '~> 2.14.2'
  gem 'timecop'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'guard-spork'
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'rb-inotify' if /linux/ =~ RUBY_PLATFORM
  gem 'rb-readline'
  gem 'simplecov', :require => false
  gem 'spork'
  gem 'vcr'
  gem 'webmock'
end
