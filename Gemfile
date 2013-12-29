source 'http://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2'
gem 'activerecord-import', '>= 0.2.0'

gem 'twitter', '4.8.1' # Global configuration removed since version 5 =(
gem 'oauth'
gem 'yaml_db'

gem 'omniauth-twitter'

gem "twitter-bootstrap-rails", '2.2.6' #:git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'less' #need this if have less-rails?
  gem 'therubyracer', :platforms => :ruby
  #gem 'therubyracer', '0.11.0beta8' # with precompiled binaries... remove libv8
  gem 'uglifier', '>= 1.0.3'
  gem "less-rails"
  gem 'libv8', '~> 3.11.8'

end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :development do
  gem 'debugger', :require => 'debugger'
  # gem "therubyracer"
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
end
