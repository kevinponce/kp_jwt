# KpJwt
Short description and motivation.

## Usage
How to use my plugin.

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

```
$ rails generate kp_jwt:auth_controller user
```

Include the KpJwt::Auth module in your ApplicationController
```ruby
class ApplicationController < ActionController::Base
  include KpJwt::Auth
end
```

simply add authenticate_user before action to the actions you need to secure
```ruby
class SecuredController < ApplicationController
  before_action :authenticate_user
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
