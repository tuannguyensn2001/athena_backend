FactoryBot.define do
  factory :target_object do
    sequence(:target_type) { %i[workshop user member].sample }
    status { 'active' }
    target_id { Faker::Number.number(digits: 8) }
    tags { {} }
    properties { {
      id: Faker::Number.number(digits: 8),
    } }
  end
end
