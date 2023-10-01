# frozen_string_literal: true

module PermissionService
  class GetSidebar < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless is_member?

      {
        member: MemberPolicy.new(auth_context).use?
      }
    rescue StandardError => e
      add_error e.message
    end
  end
end
