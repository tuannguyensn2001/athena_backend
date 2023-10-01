# frozen_string_literal: true

module Api
  module Authentication
    extend ActiveSupport::Concern

    included do
      helpers do
        def authenticate!
          token = get_token_from_header

          service = AuthService::Verify.new(token)
          result = service.call
          return error!({ message: 'Unauthorized' }, 401) if service.error?

          @current_user = result
        end

        def current_user
          @current_user
        end

        def get_token_from_header
          raw = request.headers['Authorization']
          return nil if raw.nil?

          split = raw.split(' ')
          return 'invalid' if split.length != 2 || split[0] != 'Bearer'

          split[1]
        end
      end
    end
  end
end
