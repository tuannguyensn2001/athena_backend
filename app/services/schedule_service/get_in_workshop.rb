module ScheduleService
  class GetInWorkshop < BaseService
    attr_reader :start
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find @params[:workshop_id]
      return add_error 'forbidden' unless member?

      @start = Time.at(@params[:start].to_i).to_datetime
      finish = Time.at(@params[:finish].to_i).to_datetime

      schedules = @current_workshop.schedules.joins(:setting).where("start < ?", start).where(parent_id: 0)

      schedules.each do |schedule|
        setting = schedule.setting
        next unless setting

        case setting.pattern
        when 'no_repeat'

        when 'this_day_next_week'
          handle_schedule_this_day_next_week(schedule)
        else
          add_error 'unknown pattern'
        end

      end

      @current_workshop.schedules.where('start > ? AND start < ?', start, finish)

    rescue StandardError => e
      add_error e.message
    end

    private

    def handle_schedule_this_day_next_week(schedule)
      this_monday = @start.beginning_of_week.to_date
      before_monday = schedule.start.to_date.beginning_of_week.to_date
      diff = (this_monday - before_monday).to_i / 7
      new_start = schedule.start + diff.weeks
      schedule_future = Schedule.where(
        name: schedule.name,
        start: new_start,
        workshop_id: schedule.workshop_id,
      ).first

      return if schedule_future.present?

      schedule_future = schedule.dup
      schedule_future.parent_id = schedule.id
      schedule_future.start = new_start
      schedule_future.save!
    end
  end
end
