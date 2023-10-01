# frozen_string_literal: true

module WorkshopService
  class GetByCode < BaseService
    def initialize(current_user, params)
      super
      @params = params
      @current_user = current_user
    end

    def call
      @current_workshop = Workshop.find_by_code(@params[:code])
      return add_error 'forbidden' unless member?

      @current_workshop
    end

    def member?
      WorkshopPolicy.new(auth_context).member?
    end
  end
end
