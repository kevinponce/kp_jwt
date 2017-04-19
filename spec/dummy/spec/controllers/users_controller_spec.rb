# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'
require 'kp_jwt/tokens/auth'

describe UsersAuthController, type: :controller do
  include GenericSupport

  describe 'POST #create' do
    let!(:user) { User.create(email: 'ex@ample.com', password: 'password123') }
    describe 'new user' do
      before(:each) { post :create, params: { auth: { email: 'ex@ample.com', password: 'password123' } } }

      it { expect(response).to be_success }
      it { expect(response.status).to eq(201) }
      it { expect(body_as_json(response)[:auth_token]).to_not be_nil }
      it { expect(body_as_json(response)[:refresh_token]).to_not be_nil }
      it { expect(body_as_json(response)[:errors]).to be_nil }
    end

    describe 'already exsist' do
      before(:each) { post :create, params: { auth: { email: user.email, password: 'password1234' } } }

      it { expect(response).to_not be_success }
      it { expect(response.status).to eq(401) }
      it { expect(body_as_json(response)[:auth_token]).to be_nil }
      it { expect(body_as_json(response)[:refresh_token]).to be_nil }
      it { expect(body_as_json(response)[:errors]).to_not be_nil }
    end
  end

  describe 'PUT #update' do
    let!(:user) { User.create(email: 'ex@ample.com', password: 'password123') }
    let!(:refresh_token) { KpJwt::Tokens::Refresh.new(user.id, 'user').build }

    describe 'valid refresh_token' do
      before(:each) do
        headers = { 'Authorization': "JWT #{refresh_token}" }
        request.headers.merge! headers
        put :update
      end

      it { expect(response.status).to eq(201) }
      it { expect(body_as_json(response)[:auth_token]).to_not be_nil }
      it { expect(body_as_json(response)[:errors]).to be_nil }
    end

    describe 'invalid refresh_token' do
      before(:each) do
        token_params = refresh_token.to_s.split('.')
        token_params[1].reverse!

        headers = { 'Authorization': "JWT #{token_params}" }
        request.headers.merge! headers
        put :update
      end

      it { expect(response.status).to eq(401) }
      it { expect(body_as_json(response)[:auth_token]).to be_nil }
      it { expect(body_as_json(response)[:errors]).to_not be_nil }
    end

    describe 'refresh_token revoked' do
      before(:each) do
        tokens = KpJwt::JsonWebToken.decode(refresh_token)
        KpJwtToken.find_by(tokens).update_attributes(revoked: true)

        headers = { 'Authorization': "JWT #{refresh_token}" }
        request.headers.merge! headers
        put :update
      end

      it { expect(response.status).to eq(401) }
      it { expect(body_as_json(response)[:auth_token]).to be_nil }
      it { expect(body_as_json(response)[:errors]).to_not be_nil }
    end
  end
end
