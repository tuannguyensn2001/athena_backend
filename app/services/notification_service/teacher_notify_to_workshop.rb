# frozen_string_literal: true

module NotificationService
  class TeacherNotifyToWorkshop < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless is_teacher_in_workshop?

      notification_workshop = NotificationWorkshop.new(
        content: @params[:content],
        workshop_id: @params[:workshop_id],
        user_id: @current_user&.id
      )
      notification_workshop.save!
      TeacherNotifyToWorkshopJob.perform_later(notification_workshop.id)
    rescue StandardError => e
      add_error e.message
    end
  end
end
