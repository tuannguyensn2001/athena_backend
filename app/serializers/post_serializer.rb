# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :workshop_id, :pinned_at, :created_at, :updated_at, :number_of_comments

  include TimestampSerializer

  belongs_to :user, serializer: UserSerializer
  # has_many :comments

  def number_of_comments
    object.comments.length
  end
end
