module Api::V1
  class Auth < Grape::API
    version 'v1', using: :path

    include Api::Authentication
    include Api::Logger

    resource :auth do
      desc 'Login'
      params do
        requires :phone, type: String, desc: 'Phone number'
        requires :password, type: String, desc: 'Password'
        requires :role, type: String, desc: 'Role'
      end
      post :login do
        service = AuthService::Login.new(params)
        result = service.call
        if service.success?
          {
            message: "success",
            data: result
          }
        else
          error!({ message: service.errors }, 500)
        end
      end

      desc 'Register'
      params do
        requires :phone, type: String, desc: 'Phone number'
        requires :password, type: String, desc: 'Password'
        requires :role, type: String, desc: 'Role'
        requires :email, type: String, desc: 'Email'
        requires :username, type: String, desc: 'Username'
        optional :school, type: String, desc: 'School'
        optional :birthday, type: String, desc: 'Birthday'
      end
      post :register do
        service = AuthService::Register.new(params)
        service.call
        if service.success?
          {
            message: "success"
          }
        else
          error!({ message: service.errors }, 400)
        end
      end

      desc 'Get profile'
      get :me do
        authenticate!
        logger.info current_user
        {
          message: UserSerializer.new(current_user)
        }
      end
    end
  end
end
