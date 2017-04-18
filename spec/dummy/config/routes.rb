# frozen_string_literal: true

Rails.application.routes.draw do
  mount KpJwt::Engine => '/kp_jwt'
end
