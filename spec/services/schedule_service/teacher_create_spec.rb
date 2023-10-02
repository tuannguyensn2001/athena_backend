require 'rails_helper'

RSpec.describe ScheduleService::TeacherCreate do
  let!(:teacher){ FactoryBot.create(:user, role: :teacher) }
  let!(:workshop) { FactoryBot.create(:workshop) }
  let!(:member) { FactoryBot.create(:member, user: teacher, workshop: workshop,status: :active, role: :teacher) }
  let(:params) do
    {
      name: 'test',
      workshop_id: workshop.id,
      channel: :offline,
      start: Time.now.to_i, # Time.at(0).to_time(
      minutes: 60,
      approve_update_status_automatically: false,
      pattern: :no_repeat
    }
  end
  let(:service) { described_class.new(teacher, params) }

  describe '#call' do
    context 'valid params' do
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        expect(Schedule.count).to eq 1
        schedule = Schedule.first
        expect(schedule.start).to eq Time.at(params[:start]).to_time
      end
    end
  end
end
