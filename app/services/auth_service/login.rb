module AuthService
  class Login < BaseService
    def initialize(params, secret_key = "athena")
      super
      @params = params
      @secret_key = secret_key
    end

    def call
      user = User.where(phone: @params[:phone], role: @params[:role]).first!

      if need_verify? && !user.verified?
        return add_error("Account not verified")
      end

      my_password = BCrypt::Password.new(user.password)
      return add_error("Username or password not valid") unless my_password == @params[:password]

      payload = {
        data: {
          id: user.id,
          role: user.role,
          phone: user.phone,
          email: user.email
        },
        exp: Time.now.to_i + 4 * 3600
      }
      token = JWT.encode payload, @secret_key, "HS256"

      {
        access_token: token
      }

    rescue StandardError => e
      return add_error("Username or password not valid")
    end

    def need_verify?
      AccountPolicy.new.need_verified?
    end
  end
end
