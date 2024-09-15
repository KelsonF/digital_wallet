class AuthService
    SECRET_KEY = Rails.application.secret_key_base

    def self.encode(payload, expiration_time = 12.hours.from.now)
        payload[:expiration_time] = expiration_time.to_i

        JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
        decoded_token = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new(decoded_token)
    rescue JWT::DecodeError => e
        raise e
    end
end
