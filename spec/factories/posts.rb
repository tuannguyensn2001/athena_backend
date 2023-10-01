# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { 'MyString' }
    user_id { 1 }
    workshop_id { 1 }
    pinned_at { 1 }
    deleted_at { '2023-09-29 14:47:22' }
  end
end
