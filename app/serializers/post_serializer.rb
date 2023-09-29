class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :workshop_id, :pinned_at, :created_at, :updated_at

  include TimestampSerializer

  belongs_to :user, serializer: UserSerializer
end
