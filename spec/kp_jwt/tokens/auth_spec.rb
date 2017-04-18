# frozen_string_literal: true

require 'spec_helper_integration'
require 'kp_jwt/tokens/auth'

describe KpJwt::Tokens::Auth do
  it { expect(KpJwt::Tokens::Auth.new(1, 'user').build).to_not be_nil }
end
