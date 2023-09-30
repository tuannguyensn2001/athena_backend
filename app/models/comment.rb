class Comment < ApplicationRecord
  acts_as_paranoid
  validates :content, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :user
  belongs_to :post
end
