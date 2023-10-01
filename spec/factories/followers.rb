# frozen_string_literal: true

FactoryBot.define do
  factory :follower do
    followable { nil }
    user_id { 1 }
  end
end
