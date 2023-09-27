class User < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  validates :email, presence: true
  validates :role, inclusion: { in: %w(teacher student) }
  enum :role => [:teacher, :student]

  has_one :profile, dependent: :destroy
end
