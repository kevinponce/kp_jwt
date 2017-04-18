# frozen_string_literal: true

# handles api endpoint for user
class SecureController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { user: current_user }
  end
end
