# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include TimestampSerializer
  attributes :id, :phone, :email, :role, :created_at, :updated_at, :profile
  has_one :profile
end
