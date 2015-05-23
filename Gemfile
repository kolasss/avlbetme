ruby '2.2.1'

source 'https://rubygems.org'


gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass'
gem "autoprefixer-rails" #auto web prefixes for css
gem 'annotate'
gem "slim-rails"

gem "sorcery"
gem 'pundit'

gem 'simple_form'
gem 'rails-i18n' #переводы

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'thin'
end

group :test do
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  # gem 'guard-minitest'
end

group :development do
  gem 'guard' # NOTE: this is necessary in newer versions
  gem 'guard-minitest'
end
