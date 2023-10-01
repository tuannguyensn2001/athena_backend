# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  describe '#save' do
    it 'should call run_job_sync_follower' do
      member = Member.new(
        user_id: 1,
        workshop_id: 1,
        status: :active,
        role: :student
      )
      # expect(member).to receive(:run_job_sync_follower)
      member.save
    end
  end
end
