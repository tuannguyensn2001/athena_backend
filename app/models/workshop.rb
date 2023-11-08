# frozen_string_literal: true

class Workshop < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :grade, presence: true
  validates :subject, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :posts, dependent: :destroy
  has_many :schedules

  enum subscription_plan: SubscriptionPlan::PLAN

  after_commit :sync_target_object

  Workshop.columns.each do |column|
    next unless column.type == :boolean

    define_method "#{column.name}?" do
      send(column.name)
    end
  end

  def sync_target_object
    SyncTargetObjectJob.perform_later("Workshop", id)
  end
end
