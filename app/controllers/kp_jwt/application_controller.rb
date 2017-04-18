# frozen_string_literal: true

module KpJwt
  # base for all kp jwt controllers
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
