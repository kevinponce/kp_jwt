# frozen_string_literal: true

module KpJwt
  # install generator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'Creates a KpJwt initializer.'

    def install
      template 'create_kp_jwt_tokens.rb', "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_kp_jwt_tokens.rb"
    end

    def copy_initializer
      template 'kp_jwt.rb', 'config/initializers/kp_jwt.rb'
    end
  end
end