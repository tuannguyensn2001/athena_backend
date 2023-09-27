class Profile < ApplicationRecord
  belongs_to :user
  validates :username, presence: true
  validates :avatar_url, presence: true
end
