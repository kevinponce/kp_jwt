# frozen_string_literal: true

# app/controllers/auth_controller.rb
module KpJwt
  # auth controller
  class AuthController < ApplicationController
    include Auth

    before_action :authenticate, only: [:create]

    def create
      render json: {
        auth_token: Tokens::Auth.new(entity.id, entity_name).build,
        refresh_token: Tokens::Refresh.new(entity.id, entity_name).build
      }, status: :created
    end

    def update
      return unauthorized unless refresh_auth_token

      render json: {
        auth_token: refresh_auth_token
      }, status: :created
    end

    private

    def auth_params
      params.require(:auth).permit :email, :password
    end

    def authenticate
      return true if entity.present? && entity.authenticate(auth_params[:password])

      unauthorized
    end

    def entity_name
      self.class.name.scan(/\w+/).last.split('AuthController').first.singularize
    end

    def entity_class
      entity_name.constantize
    end

    def entity
      @entity ||= entity_class.find_by email: auth_params[:email]
    end

    def refresh_auth_token
      @new_auth_token ||= Tokens::Auth.new(tokens[:id], tokens[:entity]).build if Tokens::Valid.new(http_jwt_token).refresh?
    end
  end
end
