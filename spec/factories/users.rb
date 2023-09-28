FactoryBot.define do
  factory :user do
    phone { "0984565910" }
    email { Faker::Internet.email }
    password { BCrypt::Password.create("java2001") }
    role { "teacher" }
  end
end
