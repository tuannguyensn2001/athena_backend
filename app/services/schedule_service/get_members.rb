module ScheduleService
  class GetMembers < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      schedule = Schedule.find @params[:schedule_id]
      @current_workshop = schedule.workshop
      return add_error 'forbidden' unless teacher_in_workshop?

      member_attendance = schedule.schedule_attendances.select(:user_id).distinct.pluck(:user_id)
      members = @current_workshop.members.select(:user_id).where(role: :student).where.not(id: member_attendance).pluck(:user_id)

      {
        attendance: User.where(id: member_attendance),
        not_attendance: User.where(id: members)
      }

    rescue StandardError => e
      add_error e.message
    end
  end
end
