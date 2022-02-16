source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
gem 'rails-i18n'

# Use postgresql as the database for Active Record
gem 'pg'
# gem 'mysql2', '>= 0.3.13', '< 0.5'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# serves 1.10.6 that became old
# gem 'jquery-datatables-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# comes with devise
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# foundation
gem 'foundation-rails', '~> 6.2.4'
gem 'foundation-icons-sass-rails', '~> 3.0.0'
# gem 'will_paginate-foundation'

gem 'haml-rails'

gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'

gem 'dotenv-rails'
gem 'friendly_id'
gem 'paperclip'
gem 'route_translator'
gem 'simple_form'
gem 'social-share-button'

gem 'dalli'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  # config/environments/development.rb file_watcher method requires this to decide how and when reload a file
  gem 'listen'

  gem 'annotate'
  gem 'brakeman', :require => false
  gem 'rubocop', :require => false
  gem 'bundler-audit', :require => false
  gem 'rails-erd'

  # gem 'flog'
  # gem 'flay'

  gem 'i18n-tasks'
end

