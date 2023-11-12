FactoryBot.define do
  factory :feature_flag do
    code { "code" }
    description { "MyString" }
    sequence(:state) { %i[released open_beta closed_beta] }
    sequence(:target_type) { %i[workshop user member].sample }
    condition { nil }
  end
end
