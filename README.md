# KpJwt
A simplistic jwt authentication for rails api.

# Getting Started

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'kp_jwt'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install kp_jwt
```

Run the install generator:
```
$ rails generate kp_jwt:install
```

It will create an initializers, and migration file.

Next, create auth controller for specific entity by running the following command. e.g. admin, user, etc...

```
$ rails generate kp_jwt:auth_controller user
```

### Model
If you have not create your entity model, run the following command(e.g. admin, user, etc...):
```
$ rails generate kp_jwt:model user
```
else create a model that has method authenticate and include include KpJwt::Model or uses has_secure_password like the following code:
```ruby
class User < ActiveRecord::Base
  has_secure_password

  include KpJwt::Model
end
```

### Secure
Include the KpJwt::Auth module in your ApplicationController
```ruby
class ApplicationController < ActionController::Base
  include KpJwt::Auth
end
```

Simply add authenticate_user! before action to the actions you need to secure
```ruby
class SecuredController < ApplicationController
  before_action :authenticate_user!
end
```

```
POST /user_auth
params: {
  auth: {
    email: 'ex@ample.com',
    password: 'password123'
  }
}
```

User current_user to access current user data model
```ruby
current_user.email
current_user.child_models
```

## Contributing

1. Fork it ( https://github.com/kevinponce/kp_jwt )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
