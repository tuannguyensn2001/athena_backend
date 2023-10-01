# frozen_string_literal: true

FactoryBot.define do
  factory :notification_workshop do
    content { 'MyString' }
    workshop_id { 1 }
    user_id { 1 }
    deleted_at { 1 }
  end
end
