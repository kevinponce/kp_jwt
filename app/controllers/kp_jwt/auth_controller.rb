# frozen_string_literal: true

# app/controllers/auth_controller.rb
module KpJwt
  require 'json_web_token'

  # auth controller
  class AuthController < ApplicationController
    before_action :authenticate, only: [:create]

    def create
      render json: {
        auth_token: build_auth_token(entity.id),
        refresh_token: build_refresh_token(entity.id)
      }, status: :created
    end

    def update
      rat = refresh_auth_token
      return unauthorized unless rat

      render json: {
        auth_token: rat
      }, status: :created
    end

    private

    def http_token
      @http_token ||= request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    end

    def auth_params
      params.require(:auth).permit :email, :password
    end

    def authenticate
      return true if entity.present? && entity.authenticate(auth_params[:password])

      unauthorized
    end

    def refresh_auth_token
      tokens = JsonWebToken.decode(http_token)
      return unless tokens && tokens[:id].to_i

      build_auth_token(tokens[:id].to_i)
    end

    def build_auth_token(id)
      body = { id: id }
      body[:exp] = KpJwt.token_lifetime.from_now.to_i if KpJwt.token_lifetime
      JsonWebToken.encode(body)
    end

    def build_refresh_token(id)
      return unless KpJwt.token_lifetime

      body = { id: id }
      body[:exp] = KpJwt.refresh_token_lifetime.from_now.to_i if KpJwt.refresh_token_lifetime
      JsonWebToken.encode(body) if body && KpJwt.refresh_token_required
    end

    def entity
      @entity ||= entity_class.find_by email: auth_params[:email]
    end

    def entity_class
      entity_name.constantize
    end

    def entity_name
      self.class.name.scan(/\w+/).last.split('AuthController').first.singularize
    end

    def unauthorized
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end
end
