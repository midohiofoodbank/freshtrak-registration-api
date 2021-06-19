# frozen_string_literal: true

source 'https://rubygems.org'

gem 'active_model_serializers', '~> 0.10.10'
gem 'faraday', '~> 1.0'
gem 'faraday_middleware', '~> 1.0'

gem 'jets', '~> 3.0.5'
gem 'jwt', '~> 2.2.1'
gem 'sendgrid-ruby'
gem 'twilio-ruby'

gem 'mysql2', '~> 0.5.2'

# development and test groups are not bundled as part of the deployment
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'puma'
  gem 'rack'
  gem 'rubocop', '~> 0.82.0', require: false
  gem 'rubocop-rails', '~> 2.5', require: false
  gem 'rubocop-rspec', '~> 1.38', require: false
  gem 'shotgun'
  gem 'whenever', require: false
end

group :test do
  gem 'capybara'
  gem 'launchy'
  # rspec test group only or we get the
  # "irb: warn: can't alias context from irb_context warning"
  # when starting jets console
  gem 'database_cleaner-active_record', '~> 1.8'
  gem 'factory_bot', '~> 5.1'
  gem 'faker', '~> 2.11'
  gem 'rspec'
  gem 'simplecov', '~> 0.18.5', require: false
  gem 'simplecov-cobertura', '~> 1.3', require: false
  gem 'timecop', '~> 0.9.1'
end
