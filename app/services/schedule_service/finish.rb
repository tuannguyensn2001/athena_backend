module ScheduleService
  class Finish < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      schedule = Schedule.find @params[:schedule_id]
      @current_workshop = schedule.workshop
      return add_error 'forbidden' unless teacher_in_workshop?
      return add_error 'schedule already finished' if schedule.finished?

      schedule.finished!

    rescue StandardError => e
      add_error e.message
    end
  end
end
