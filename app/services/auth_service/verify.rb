module AuthService
  class Verify < BaseService
    def initialize(token, secret_key = 'athena')
      super
      @token = token
      @secret_key = secret_key
    end

    def call
      decoded = JWT.decode @token, @secret_key
      payload = decoded[0].deep_symbolize_keys
      user_id = payload[:data][:id]
      User.find(user_id)
    rescue StandardError
      return add_error('Invalid or expired token.')
    end
  end
end
