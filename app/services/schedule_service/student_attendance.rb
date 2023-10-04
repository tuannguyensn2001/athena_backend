module ScheduleService
  class StudentAttendance < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      schedule = Schedule.find(@params[:schedule_id])
      @current_workshop = schedule.workshop
      return add_error 'forbidden' unless teacher_in_workshop?

      student = User.find(@params[:student_id])
      workshop_policy = WorkshopPolicy.new(AuthContext.new(user: student, workshop: schedule.workshop))
      return add_error 'forbidden' unless workshop_policy.student?

      return add_error 'schedule already finished' if schedule.finished?

      ScheduleAttendance.new(
        schedule:,
        user: student,
      ).save!

    rescue StandardError => e
      add_error e.message
    end
  end
end
