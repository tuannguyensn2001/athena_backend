FactoryBot.define do
  factory :user do
    phone  { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    password { BCrypt::Password.create("java2001") }
    role { "teacher" }
  end
end
