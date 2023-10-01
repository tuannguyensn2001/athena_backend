# frozen_string_literal: true

module NotificationService
  class GetNotificationInWorkshop < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find @params[:workshop_id]
      return add_error 'forbidden' unless member?

      NotificationWorkshop.where(workshop_id: @params[:workshop_id])
    rescue StandardError => e
      add_error e.message
    end
  end
end
