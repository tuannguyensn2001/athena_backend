FactoryBot.define do
  factory :custom_attribute do
    name { "MyString" }
    target_type { "MyString" }
    data_type { "MyString" }
    description { "MyString" }
    visible { false }
  end
end
