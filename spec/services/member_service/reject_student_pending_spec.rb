# frozen_string_literal: true

require 'rails_helper'

describe MemberService::RejectStudentPending do
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
  let(:reject_all) { false }
  let(:params) do
    {
      workshop_id: workshop.id,
      student_id: student_1.id,
      reject_all:
    }
  end
  let(:service) { described_class.new(teacher, params) }

  describe '#call' do
    context 'reject one' do
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        member_2.reload
        expect(member_2.pending?).to eq true
        expect(Member.count).to eq 2
      end
    end

    context 'reject all' do
      let(:reject_all) { true }
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        expect(Member.count).to eq 1
      end
    end
  end
end
