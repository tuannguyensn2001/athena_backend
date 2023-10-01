# frozen_string_literal: true

FactoryBot.define do
  factory :workshop do
    name { 'MyString' }
    thumbnail { 'MyString' }
    private_code { 'MyString' }
    code { 'MyString' }
    approve_student { false }
    prevent_student_leave { false }
    approve_show_score { false }
    disable_newsfeed { false }
    limit_policy_teacher { false }
    is_show { true }
    subject { 'MyString' }
    grade { 'MyString' }
    is_lock { false }
  end
end
