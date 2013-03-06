source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'ginjo-rfm' # up-to-date fork of Ruby FileMaker API

# Gems for development
group :development do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'hirb'      # print formatted result tables to console

  # These gems are for triggering tasks upon file changes with Guard
  gem 'rb-fsevent', :require => false
  gem 'guard-bundler'    # run bundle install
  gem 'guard-livereload' # reload the browser
  gem 'rack-livereload'  # use livereload as a Rack middleware
end

# Gems for both development and production
group :development, :production do
  gem 'gmaps4rails'
end

# Gems for production only: PostgreSQL (gem 'pg') is required for Heroku
group :production do
  gem 'thin' # is said to be more robust than WEBrick
             # still only a temporary solution, of course
             # will need to check out Phusion Passenger 
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.1.0.0' # use Twitter Bootstrap 2.1 with SASS

  gem 'jquery-datatables-rails'      # use assets from jQuery Datatables gem
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password: gem 'bcrypt-ruby', '~> 3.0.0'
# To use Jbuilder templates for JSON: gem 'jbuilder'
# Use unicorn as the app server: gem 'unicorn'
# Deploy with Capistrano: gem 'capistrano'
# To use debugger: gem 'ruby-debug19', :require => 'ruby-debug'
