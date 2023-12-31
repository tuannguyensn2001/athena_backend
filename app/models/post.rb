# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_paranoid

  validates :content, presence: true
  validates :user_id, presence: true
  validates :workshop_id, presence: true

  has_many :comments
  belongs_to :user
  belongs_to :workshop
end
