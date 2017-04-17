Rails.application.routes.draw do
  mount KpJwt::Engine => "/kp_jwt"
end
