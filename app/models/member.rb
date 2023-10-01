# frozen_string_literal: true

class Member < ApplicationRecord
  enum role: {
    student: 'student',
    teacher: 'teacher'
  }

  enum status: {
    pending: 'pending',
    active: 'active'
  }

  belongs_to :user
  belongs_to :workshop

  after_commit :run_job_sync_follower

  def run_job_sync_follower
    SyncMemberToFollowerJob.perform_later attributes
  end
end
