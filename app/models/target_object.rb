class TargetObject < ApplicationRecord

  validates :target_id, presence: true
  # validates :tags, presence: true
  validates :properties, presence: true

  has_many :feature_flag_objects, dependent: :destroy
  has_many :feature_flags, through: :feature_flag_objects

  enum target_type: {
    workshop: 'workshop',
    user: 'user',
    member: 'member',
  }.freeze

  enum status: {
    active: 'active',
    inactive: 'inactive',
  }.freeze
end
