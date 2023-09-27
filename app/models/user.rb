class User < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  validates :email, presence: true
  # validates :role, inclusion: %w[teacher student], presence: true
  enum role: { teacher: "teacher", student: "student" }

  has_one :profile, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :workshops, through: :members
end
