module KpJwt
  module Auth
    def authenticate_user!(silent = false)
      return unauthorized(silent) unless Tokens::Valid.new(http_jwt_token).auth?
    end

    def current_user
      @current_user ||= entity_class.find(tokens[:entity_id]) if Tokens::Valid.new(http_jwt_token).auth? && entity_class
    end

    def current_user_type
      @current_user ||= entity_class.find(tokens[:entity_id]) if Tokens::Valid.new(http_jwt_token).auth? && entity_class
    end

    private

    def http_jwt_token
      @http_jwt_token ||= request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    end

    def tokens
      @tokens ||= JsonWebToken.decode(http_jwt_token)
    end

    def unauthorized(silent = false)
      render json: { errors: { base: ['Not Authenticated'] } }, status: :unauthorized unless silent
    end

    def entity_class
      tokens[:entity].capitalize.constantize if tokens && tokens[:entity]
    end
  end
end