FactoryBot.define do
  factory :schedule do
    name { Faker::Name.name }
    sequence(:channel) { %i[zoom google_meet offline].sample }
    start { Faker::Time.backward(days: 90) }
    minutes { 90 }
    sequence(:status) { %i[in_progress finished pending].sample }
    approve_update_status_automatically { Faker::Boolean.boolean }
  end
end
