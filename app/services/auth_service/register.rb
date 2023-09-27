module AuthService
  class Register < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      return unless validate_password

      @params[:password] = BCrypt::Password.create(@params[:password])

      user = User.new(
        phone: @params[:phone],
        email: @params[:email],
        password: @params[:password],
        role: @params[:role]
      )

      user.profile = Profile.new(
        username: @params[:username],
        school: @params[:school],
        birthday: Time.at(@params[:birthday].to_i).utc,
        avatar_url: "https://img.freepik.com/free-icon/user_318-563642.jpg",
      )

      return add_error(user.errors.full_messages) unless user.save
    rescue StandardError => e
      add_error(e.message)
      return
    end

    private

    def validate_password
      if @params[:password].nil? || @params[:password].length.zero?
        add_error('Password is required')
        false
      end
      true
    end
  end
end
