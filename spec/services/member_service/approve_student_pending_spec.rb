# frozen_string_literal: true

require 'rails_helper'

describe MemberService::ApproveStudentPending do
  let!(:teacher) { FactoryBot.create(:user, role: :teacher) }
  let!(:student_1) { FactoryBot.create(:user, role: :student) }
  let!(:student_2) { FactoryBot.create(:user, role: :student) }
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:member_1) do
    FactoryBot.create(:member, user_id: student_1.id, workshop_id: workshop.id, role: :student, status: :pending)
  end
  let!(:member_2) do
    FactoryBot.create(:member, user_id: student_2.id, workshop_id: workshop.id, role: :student, status: :pending)
  end
  let!(:member_teacher) do
    FactoryBot.create(:member, user_id: teacher.id, workshop_id: workshop.id, role: :teacher, status: :active)
  end
  let(:approve_all) { false }
  let(:params) do
    {
      workshop_id: workshop.id,
      student_id: student_1.id,
      approve_all:
    }
  end
  let(:service) { described_class.new(teacher, params) }

  describe '#call' do
    context 'approve one' do
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        member_1.reload
        member_2.reload
        expect(member_1.active?).to eq true
        expect(member_2.pending?).to eq true
      end
    end

    context 'approve all' do
      let(:approve_all) { true }
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        member_1.reload
        member_2.reload
        expect(member_1.active?).to eq true
        expect(member_2.active?).to eq true
      end
    end
  end
end
