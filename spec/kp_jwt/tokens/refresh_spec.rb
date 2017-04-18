# frozen_string_literal: true

require 'spec_helper_integration'
require 'kp_jwt/tokens/auth'

describe KpJwt::Tokens::Refresh do
  it { expect(KpJwt::Tokens::Refresh.new(1, 'user').build).to_not be_nil }

  describe 'token_lifetime is nil' do
    before(:each) { allow(KpJwt).to receive(:token_lifetime).and_return(nil) }

    it { expect(KpJwt::Tokens::Refresh.new(1, 'user').build).to be_nil }
  end
end
