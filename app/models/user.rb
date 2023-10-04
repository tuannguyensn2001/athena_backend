# frozen_string_literal: true

class User < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  validates :email, presence: true
  # validates :role, inclusion: %w[teacher student], presence: true
  enum role: { teacher: 'teacher', student: 'student' }

  has_one :profile, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :workshops, through: :members
  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy

  has_many :schedule_attendances, dependent: :destroy
  has_many :schedules, through: :schedule_attendances

  def verified?
    email_verified_at.present?
  end
end
