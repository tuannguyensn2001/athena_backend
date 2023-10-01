# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    from_user_id { 1 }
    to_user_id { 1 }
    read_at { '2023-10-01 09:19:05' }
    payload { '' }
    pattern { 'MyString' }
  end
end
