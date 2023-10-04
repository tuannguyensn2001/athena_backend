class Schedule < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :channel, presence: true
  validates :start, presence: true
  validates :approve_update_status_automatically, inclusion: { in: [true, false] }

  belongs_to :workshop
  belongs_to :author, class_name: 'User', foreign_key: 'created_by'
  has_one :setting, class_name: 'ScheduleSetting', dependent: :destroy

  enum channel: {
    offline: 'offline',
    zoom: 'zoom',
    google_meet: 'google_meet',
  }

  enum status: {
    pending: 'pending',
    in_progress: 'in_progress',
    finished: 'finished',
  }

  has_many :schedule_attendances, dependent: :destroy
  has_many :users, through: :schedule_attendances
end
