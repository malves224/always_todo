class JsonWebToken
  SECRET_KEY = ENV['jwt_secret'] || 'secret'

  def self.encode(payload, exp = 99_999.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body)
  end
end
