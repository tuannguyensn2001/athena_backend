class WorkshopSerializer < ActiveModel::Serializer
  include TimestampSerializer
  attributes :id, :name, :thumbnail, :private_code, :approve_student, :prevent_student_leave, :approve_show_score,
             :disable_newsfeed, :limit_policy_teacher, :is_show, :subject, :grade, :is_lock, :created_at, :updated_at, :subscription_plan
end
