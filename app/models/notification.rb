# frozen_string_literal: true

class Notification < ApplicationRecord
  enum pattern: {
    teacher_notify_to_workshop: 'teacher_notify_to_workshop'
  }

  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
end
