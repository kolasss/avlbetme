source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'pg'
gem 'annotate' #ruby model annotations
gem "sorcery" #user auth
gem 'pundit'
gem 'kaminari' #pagination

gem "slim-rails"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

gem 'bootstrap-sass'
gem "font-awesome-rails"

gem 'simple_form'
gem 'rails-i18n' #переводы

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  gem 'webmock' #mocking web requests
  gem 'simplecov', :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  gem 'guard' # NOTE: this is necessary in newer versions
  gem 'guard-minitest'

  # ruby deployment system
  gem "capistrano", "~> 3.4"
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.2'
end
