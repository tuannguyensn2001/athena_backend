class Post < ApplicationRecord
  acts_as_paranoid

  validates :content, presence: true
  validates :user_id, presence: true
  validates :workshop_id, presence: true

  belongs_to :user
  belongs_to :workshop
end
