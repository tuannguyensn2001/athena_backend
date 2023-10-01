# frozen_string_literal: true

require 'rails_helper'

describe MemberService::AddStudent do
  let!(:teacher) { FactoryBot.create(:user, phone: '0397296810', role: :teacher) }
  let!(:student) { FactoryBot.create(:user, phone: '0984565910', role: :student) }
  let!(:workshop) { FactoryBot.create(:workshop) }
  let!(:member_teacher) do
    FactoryBot.create(:member, user_id: teacher.id, workshop_id: workshop.id, role: :teacher, status: :active)
  end

  let(:params) do
    {
      phone: student.phone,
      workshop_id: workshop.id
    }
  end
  let(:service) { described_class.new(teacher, params) }

  describe '#call' do
    context 'target member is student and not existed' do
      it 'returns success' do
        service.call
        expect(service.success?).to eq(true)
        expect(Member.count).to eq(2)
        member = Member.last
        expect(member.user_id).to eq(student.id)
        expect(member.workshop_id).to eq(workshop.id)
        expect(member.student?).to eq(true)
        expect(member.active?).to eq(true)
      end
    end

    context 'target member is not student' do
      before do
        student.teacher!
      end

      it 'returns error' do
        service.call
        expect(service.error?).to eq(true)
      end
    end

    context 'target member is student and existed and active' do
      before do
        FactoryBot.create(:member, user_id: student.id, workshop_id: workshop.id, role: :student, status: :active)
      end

      it 'returns error' do
        service.call
        expect(service.error?).to eq(true)
      end
    end

    context 'target member is student and existed but pending' do
      before do
        FactoryBot.create(:member, user_id: student.id, workshop_id: workshop.id, role: :student, status: :pending)
      end

      it 'returns error' do
        service.call
        expect(service.success?).to eq(true)
        expect(Member.first.active?).to eq true
      end
    end
  end
end
