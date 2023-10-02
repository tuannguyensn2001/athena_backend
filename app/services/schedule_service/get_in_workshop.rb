module ScheduleService
  class GetInWorkshop < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find @params[:workshop_id]
      return add_error 'forbidden' unless member?

      start = Time.at(@params[:start].to_i).to_datetime
      finish = Time.at(@params[:finish].to_i).to_datetime

      @current_workshop.schedules.where(start: start..finish)

    rescue StandardError => e
      add_error e.message
    end
  end
end
