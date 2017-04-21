module KpJwt
  module Model
    def create_auth_token
      Tokens::Auth.new(self.id, self.model_name.human).build
    end

    def create_refresh_token
      Tokens::Refresh.new(self.id, self.model_name.human).build
    end
  end
end