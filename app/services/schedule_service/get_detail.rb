module ScheduleService
  class GetDetail < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      schedule = Schedule.find @params[:schedule_id]
      @current_workshop = schedule.workshop
      return add_error 'forbidden' unless member?

      schedule

    rescue StandardError => e
      add_error e.message
    end
  end
end
