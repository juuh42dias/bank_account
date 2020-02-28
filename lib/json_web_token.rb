class JsonWebToken
  SECRET_KEY = SecureRandom.hex(16)

  def self.encode(payload, expire = 2.hours.from_now)
    payload[:expire] = expire.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
