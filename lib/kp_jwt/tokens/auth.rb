module KpJwt
  module Tokens
    class Auth
      TYPE = 'regular'.freeze

      attr_accessor :entity_id, :entity_name

      def initialize(entity_id, entity_name)
        self.entity_id = entity_id
        self.entity_name = entity_name
      end

      def build
        token = JsonWebToken.encode(body)
        save(token)

        token
      end

      private

      def body
        @body ||= {
          entity_id: entity_id,
          entity: entity_name,
          token_type: TYPE,
          exp: KpJwt.token_lifetime ? KpJwt.token_lifetime.from_now.to_i : nil
        }.reject { |k, v| v.nil? }
      end

      def save(token)
        KpJwtToken.create(body.merge(hashed_token: hash(token)))
      end

      def hash(token)
        Digest::SHA2.hexdigest(token)
      end
    end
  end
end
