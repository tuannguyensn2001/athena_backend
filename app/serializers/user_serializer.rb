class UserSerializer < ActiveModel::Serializer
  include TimestampSerializer
  attributes :id, :phone, :email, :role, :created_at, :updated_at
  has_one :profile
end
