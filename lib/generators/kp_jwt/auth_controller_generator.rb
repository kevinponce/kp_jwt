# frozen_string_literal: true

module KpJwt
  # generates auth controller
  class AuthControllerGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    argument :name, type: :string

    desc <<-DESC
      Creates a KpJwt auth controller for the given entity
      and add the corresponding routes.
    DESC

    def copy_controller_file
      template 'auth_controller.erb', "app/controllers/#{name.underscore}_auth_controller.rb"
    end

    def add_route
      route "post '#{name.underscore}_auth' => '#{name.underscore}_auth#create'"
      route "put '#{name.underscore}_auth' => '#{name.underscore}_auth#update'"
    end

    private

    def entity_name
      name
    end
  end
end
