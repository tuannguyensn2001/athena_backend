class TargetObject < ApplicationRecord

  validates :target_id, presence: true
  # validates :tags, presence: true
  validates :properties, presence: true

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
