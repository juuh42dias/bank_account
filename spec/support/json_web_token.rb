module Support
  module JSONWebToken
    def generate_token(user, expire = 48.hours.from_now)
      JsonWebToken.encode(user_id: user.id, expire: expire)
    end
  end
end