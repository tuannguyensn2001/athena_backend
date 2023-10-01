# frozen_string_literal: true

class NotificationWorkshop < ApplicationRecord
  acts_as_paranoid
  validates :content, presence: true

  belongs_to :workshop
  belongs_to :user
end
