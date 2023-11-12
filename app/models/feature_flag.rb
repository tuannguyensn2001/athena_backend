class FeatureFlag < ApplicationRecord

  validates :code, presence: true, uniqueness: true
  validates :state, presence: true
  validates :target_type, presence: true

  has_many :feature_flag_objects, dependent: :destroy
  has_many :target_objects, through: :feature_flag_objects

  enum state: {
    # public: 'public',
    open_beta: 'open_beta',
    closed_beta: 'closed_beta',
    released: 'released'
  }

  enum target_type: {
    user: 'user',
    workshop: 'workshop',
    member: 'member'
  }
end
