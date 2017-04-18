module KpJwt
  module Tokens
    class Refresh
      TYPE = 'refresh'.freeze
      attr_accessor :id, :entity_name

      def initialize(id, entity_name)
        self.id = id
        self.entity_name = entity_name
      end

      def build
        return unless KpJwt.token_lifetime

        JsonWebToken.encode(body) if KpJwt.refresh_token_required
      end

      private

      def body
        _body = { id: id, entity: entity_name, type: TYPE }
        _body[:exp] = refresh_token_exp if refresh_token_exp

        _body
      end

      def refresh_token_exp
        KpJwt.refresh_token_lifetime.from_now.to_i if KpJwt.refresh_token_lifetime
      end
    end
  end
end
