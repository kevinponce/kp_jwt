# frozen_string_literal: true

module KpJwt
  # install generator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'Creates a KpJwt initializer.'

    def copy_initializer
      template 'kp_jwt.rb', 'config/initializers/kp_jwt.rb'
    end
  end
end