class ScheduleSetting < ApplicationRecord
  belongs_to :schedule


  enum pattern: {
    no_repeat: 'no_repeat',
    every_day: 'every_day',
    this_day_next_week: 'this_day_next_week',
    this_day_next_month: 'this_day_next_month',
    every_day_in_week: 'every_day_in_week',
  }

  validates :pattern, presence: true, inclusion: { in: %w[no_repeat every_day this_day_next_week this_day_next_month every_day_in_week] }

end
