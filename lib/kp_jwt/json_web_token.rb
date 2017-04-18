# frozen_string_literal: true

module KpJwt
  class JsonWebToken
    NATIVE = 'native'

    class << self
      def encode(payload)
        JWT.encode(payload, KpJwt.token_secret_signature_key.call)
      end

      def decode(token)
        HashWithIndifferentAccess.new(JWT.decode(token, KpJwt.token_secret_signature_key.call)[0])
      rescue
        nil
      end
    end
  end
end
