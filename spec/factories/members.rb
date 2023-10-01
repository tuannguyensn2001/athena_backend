# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    user_id { 1 }
    workshop_id { 1 }
    role { 'MyString' }
    sequence(:status) { %i[active pending].sample }
  end
end
