FactoryBot.define do
  factory :comment do
    user_id { 1 }
    post_id { 1 }
    content { "MyString" }
    deleted_at { "2023-09-30 12:41:23" }
  end
end
