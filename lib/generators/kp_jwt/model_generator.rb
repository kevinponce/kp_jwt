# frozen_string_literal: true

module KpJwt
  # generates auth controller
  class ModelGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    argument :name, type: :string

    desc <<-DESC
      Creates a KpJwt model and migration for the given entity.
    DESC

    def install
      template 'entity_model.rb.erb', "app/models/#{entity_name.singularize.underscore}.rb"
      template 'entity_model_migration.rb', "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_#{entity_name.singularize}.rb"
    end

    private

    def entity_name
      name
    end
  end
end
