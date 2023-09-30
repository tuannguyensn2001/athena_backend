class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :post_id, :created_at, :updated_at
  include TimestampSerializer

  belongs_to :user
  # belongs_to :post
end
