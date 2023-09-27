FactoryBot.define do
  factory :member do
    user_id { 1 }
    workshop_id { 1 }
    role { "MyString" }
    status { "MyString" }
  end
end
