class ScheduleSerializer < ActiveModel::Serializer
  attributes(*Schedule.column_names)
  attributes :attendance_number, :members_number

  def start
    object.start.to_i
  end

  def end
    object.end.to_i
  end

  def attendance_number
    ScheduleAttendance.where(schedule_id: object.id).count
  end

  def members_number
    object.workshop.members.student.active.count
  end
end
