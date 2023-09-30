class Member < ApplicationRecord
  enum role: {
    student: "student",
    teacher: "teacher",
  }

  enum status: {
    pending: "pending",
    active: "active",
  }

  belongs_to :user
  belongs_to :workshop


end
