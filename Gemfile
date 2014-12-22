# -*- coding: utf-8 -*-
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# Linux環境では、JSの実行環境がないため、therubyracerをインストールするようにします
gem 'therubyracer', '~> 0.12.1', :platform => :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#responders
gem 'responders', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


gem "magellan-rails"
gem "magellan-publisher"

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem "brocket"
end

# rabbitmq_http_api_client(>= 0) が依存する multi_json (~> 1.4.0)  が、
# sass-rails(~> 4.0.3)が依存するmulti_json (1.10.1)とコンフリクトするので、
# これを使用する scripts/magellan_rabbitmq_connect_setting.rb でのみ使えるように
# Dokerfileに記述します
# group :development do
#   gem "rabbitmq_http_api_client"
#   gem "redis"
#   gem "json"
# end

# Use newrelic_rpm as the New Relic agent
gem 'newrelic_rpm'

