module Api
  module Authentication
    extend ActiveSupport::Concern

    included do
      helpers do
        def authenticate!
          token = get_token_from_header

          service = AuthService::Verify.new(token)
          result = service.call
          if service.error?
            return error!({ message: "Unauthorized" }, 401)
          end
          @current_user = result
        end

        def current_user
          @current_user
        end

        def get_token_from_header
          raw = request.headers['Authorization']
          return nil if raw.nil?
          split = raw.split(" ")
          if split.length != 2 || split[0] != "Bearer"
            return "invalid"
          end
          split[1]
        end

      end
    end
  end
end
