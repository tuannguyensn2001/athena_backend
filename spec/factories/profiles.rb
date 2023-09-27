FactoryBot.define do
  factory :profile do
    username { Faker::Name.name }
    school { Faker::Educator.university }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    avatar_url { Faker::Avatar.image }
    association :user
  end
end
