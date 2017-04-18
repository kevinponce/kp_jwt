require 'kp_jwt/engine'

module KpJwt
  mattr_accessor :token_lifetime
  self.token_lifetime = 1.day

  mattr_accessor :token_signature_algorithm
  self.token_signature_algorithm = 'HS256'

  mattr_accessor :token_audience
  self.token_audience = nil

  mattr_accessor :token_secret_signature_key
  self.token_secret_signature_key = -> { Rails.application.secrets.secret_key_base }

  mattr_accessor :refresh_token_lifetime
  self.refresh_token_lifetime = nil

  mattr_accessor :refresh_token_required
  self.refresh_token_required = true

  mattr_accessor :not_found_exception_class_name
  self.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'

  # run rails generate kp_jwt:install
  class << self
    def setup
      yield self
    end
  end
end
