source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.1.4'
gem 'jbuilder', '~> 2.0'
gem 'draper', '~>1.3'
gem 'paperclip'
gem 'rubocop', require: false
gem 'bitly'

# Authentication
gem 'devise'
gem 'bcrypt-ruby', '~> 3.0.0'

# Front-End
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'
gem 'sass-rails', '~> 4.0.3'
gem 'haml'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'bootstrap-sass-extras'
gem 'autoprefixer-rails'
gem 'select2-rails'

group :development, :test do
  gem 'rspec-rails', '~> 3.2'
  gem 'sqlite3'
  gem 'awesome_print'

  # Better Errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development do
  gem 'spring'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
