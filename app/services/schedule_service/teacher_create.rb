module ScheduleService
  class TeacherCreate < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error "forbidden" unless teacher_in_workshop?

      schedule = Schedule.new(
        name: @params[:name],
        workshop_id: @params[:workshop_id],
        channel: @params[:channel],
        start: Time.at(@params[:start].to_i).to_time,
        minutes: @params[:minutes],
        status: :pending,
        created_by: @current_user&.id,
        approve_update_status_automatically: @params[:approve_update_status_automatically],
      )
      schedule.setting = ScheduleSetting.new(
        pattern: @params[:pattern],
      )

      schedule.save!

    rescue StandardError => e
      add_error e.message
    end

  end
end
