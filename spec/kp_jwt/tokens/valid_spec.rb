# frozen_string_literal: true

require 'spec_helper_integration'

describe KpJwt::Tokens::Valid do
  let!(:auth_token) { KpJwt::Tokens::Auth.new(1, 'user').build }
  let!(:refresh_token) { KpJwt::Tokens::Refresh.new(1, 'user').build }

  describe 'auth token' do
    describe 'with exp' do
      it 'not expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE, exp: 1.day.from_now.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(auth_token).auth?).to be_truthy
      end

      it 'is expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE, exp: 1.day.ago.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(auth_token).auth?).to be_falsey
      end

      it 'invalid token not expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE, exp: 1.day.from_now.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(refresh_token).auth?).to be_falsey
      end

      it 'invalid token is expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE, exp: 1.day.ago.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(refresh_token).auth?).to be_falsey
      end
    end

    describe 'no exp' do
      it 'valid' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE)

        expect(KpJwt::Tokens::Valid.new(auth_token).auth?).to be_truthy
      end

      it 'invalid token' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE)

        expect(KpJwt::Tokens::Valid.new(refresh_token).auth?).to be_falsey
      end
    end
  end

  describe 'refresh token' do
    describe 'with exp' do
      it 'not expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE, exp: 1.day.from_now.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(refresh_token).refresh?).to be_truthy
      end

      it 'is expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE, exp: 1.day.ago.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(refresh_token).refresh?).to be_falsey
      end

      it 'invalid token not expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE, exp: 1.day.from_now.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(auth_token).refresh?).to be_falsey
      end

      it 'invalid token is expired' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE, exp: 1.day.ago.utc.to_i)

        expect(KpJwt::Tokens::Valid.new(auth_token).refresh?).to be_falsey
      end
    end

    describe 'no exp' do
      it 'valid' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(refresh_token).and_return(id: 1, type: KpJwt::Tokens::Refresh::TYPE)

        expect(KpJwt::Tokens::Valid.new(refresh_token).refresh?).to be_truthy
      end

      it 'invalid token' do
        allow(KpJwt::JsonWebToken).to receive(:decode).with(auth_token).and_return(id: 1, type: KpJwt::Tokens::Auth::TYPE)

        expect(KpJwt::Tokens::Valid.new(auth_token).refresh?).to be_falsey
      end
    end
  end
end
