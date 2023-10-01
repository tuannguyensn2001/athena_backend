# frozen_string_literal: true

class TeacherNotifyToWorkshopJob < ApplicationJob
  queue_as :default

  def perform(notification_workshop_id)
    notification_workshop = NotificationWorkshop.find notification_workshop_id

    list_user_id = Follower.select('user_id').where(
      followable: notification_workshop.workshop
    ).pluck(:user_id)

    list_teacher_id = Member.teacher.active.where(user_id: list_user_id,
                                                  workshop_id: notification_workshop.workshop.id).pluck(:user_id)

    list_student_id = list_user_id - list_teacher_id

    list_notifications = []

    list_student_id.each do |student_id|
      list_notifications << {
        to_user_id: student_id,
        from_user_id: notification_workshop.user_id,
        payload: {
          workshop: notification_workshop.workshop
        },
        pattern: :teacher_notify_to_workshop
      }
    end

    Notification.insert_all! list_notifications
  end
end
