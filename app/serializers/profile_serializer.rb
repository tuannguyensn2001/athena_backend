class ProfileSerializer < ActiveModel::Serializer
  include TimestampSerializer
  attributes :id, :username, :school, :birthday, :avatar_url, :created_at, :updated_at
end
