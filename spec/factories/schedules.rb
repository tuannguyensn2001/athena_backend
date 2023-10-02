FactoryBot.define do
  factory :schedule do
    name { "MyString" }
    channel { "MyString" }
    day { "2023-10-02 14:23:09" }
    start { "2023-10-02 14:23:09" }
    minutes { 1 }
    status { "MyString" }
    approve_update_status_automatically { false }
  end
end
