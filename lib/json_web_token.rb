require 'jwt'

class JsonWebToken
  SECRET_KEY = 'your_secret_key_here'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(decoded[0])
  end
end
