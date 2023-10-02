require 'rails_helper'

describe ScheduleService::GetInWorkshop do
  let(:user) { FactoryBot.create(:user, role: :teacher) }
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:member) { FactoryBot.create(:member, user:, workshop:, role: :teacher, status: :active) }
  let(:start) { Time.now }
  let!(:schedule1) { FactoryBot.create(:schedule, workshop:, author: user, start:) }
  let(:params) do
    {
      workshop_id: workshop.id,
      start: Date.today.beginning_of_week.to_datetime.to_i,
      finish: Date.today.next_week.beginning_of_week.to_datetime.to_i
    }
  end
  let(:service) { described_class.new(user, params) }
  describe '#call' do
    context 'schedule is in the middle of week' do
      it 'returns success' do
        result = service.call
        expect(service.success?).to eq(true)
        expect(result).to eq([schedule1])
      end
    end

    context 'schedule is not in week' do
      let(:start) { Date.today.last_week.to_datetime }

      it 'returns success' do
        result = service.call
        expect(service.success?).to eq(true)
        expect(result).to eq([])
      end
    end
  end
end
