## Dependencies
* ruby 2.4.1
* rails 5.2.3
* rspec 3.8.2

## Steps to setup rails app
* `rails new <name> -T -d='postgresql' --skip-turbolinks --skip-spring`

* Install the following gems:
```ruby
# Gemfile
...
gem 'factory_bot_rails'
gem 'faker'
gem 'faraday'
gem 'figaro'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'pry'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
```

* Setup rspec:
```
bundle install
rails g rspec:install
```

* Add PR template in root with name `PULL_REQUEST_TEMPLATE.MD`

* Setup simplecov, shoulda-matchers, capybara-email outside of `Rails.config` block:
```ruby
# spec/rails_helper.rb

require 'capybara/email/rspec'
...
SimpleCov.start "rails" do
  add_filter '/controllers/'
  add_filter '/helpers/'
  add_filter '/jobs/'
  add_filter '/channels/'
  add_filter '/creators/'
end

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```

* Setup factory_bot_rails:
```ruby
...

RSpec.configure do |config|
  ...

  config.include FactoryBot::Syntax::Methods

end
```

* Setup database
`rake db:create`
