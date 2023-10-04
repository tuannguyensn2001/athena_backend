require 'rails_helper'

describe ScheduleService::StudentAttendance do
  let(:teacher) { FactoryBot.create(:user, role: :teacher) }
  let(:student) { FactoryBot.create(:user, role: :student) }
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:member1) { FactoryBot.create(:member, user: teacher, workshop:, role: :teacher, status: :active) }
  let!(:member2) { FactoryBot.create(:member, user: student, workshop:, role: :student, status: :active) }
  let(:status) { :in_progress }
  let(:schedule) { FactoryBot.create(:schedule, workshop:, status: status, author: teacher) }
  let!(:schedule_setting) { FactoryBot.create(:schedule_setting, schedule:) }
  let(:params) do
    {
      student_id: student.id,
      schedule_id: schedule.id
    }
  end
  let(:service) { described_class.new(teacher, params) }

  describe '#call' do
    context 'schedule is not finished' do
      it 'returns true' do
        service.call
        expect(service.success?).to eq true
        expect(ScheduleAttendance.count).to eq 1
        expect(ScheduleAttendance.first.user).to eq student
        expect(ScheduleAttendance.first.schedule).to eq schedule
      end
    end

    context "schedule is finished" do
      let(:status) { :finished }

      it 'returns error' do
        service.call
        expect(service.error?).to eq true
      end
    end
  end

end
