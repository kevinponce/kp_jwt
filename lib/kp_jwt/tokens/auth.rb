module KpJwt
  module Tokens
    class Auth
      TYPE = 'regular'.freeze

      attr_accessor :id, :entity_name

      def initialize(id, entity_name)
        self.id = id
        self.entity_name = entity_name
      end

      def build
        JsonWebToken.encode(body)
      end

      private

      def body
        _body = { id: id, entity: entity_name, type: TYPE }
        _body[:exp] = KpJwt.token_lifetime.from_now.to_i if KpJwt.token_lifetime

        _body
      end
    end
  end
end
