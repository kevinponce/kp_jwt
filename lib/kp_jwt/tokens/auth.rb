module KpJwt
  module Tokens
    class Auth
      TYPE = 'regular'.freeze

      attr_accessor :entity_id, :entity_name, :token, :exp

      def initialize(entity_id, entity_name)
        self.entity_id = entity_id
        self.entity_name = entity_name
        self.token = nil
        self.exp = nil
      end

      def build
        self.exp = KpJwt.token_lifetime ? KpJwt.token_lifetime.from_now.to_i : nil
        self.token = JsonWebToken.encode(body)
        save

        self
      end

      private

      def body
        @body ||= {
          entity_id: entity_id,
          entity: entity_name,
          token_type: TYPE,
          exp: exp
        }.reject { |k, v| v.nil? }
      end

      def save
        KpJwtToken.create(body.merge(hashed_token: token_hashed))
      end

      def token_hashed
        Digest::SHA2.hexdigest(token)
      end
    end
  end
end
