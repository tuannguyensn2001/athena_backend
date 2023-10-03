require 'rails_helper'

describe ScheduleService::GetInWorkshop do
  let(:user) { FactoryBot.create(:user, role: :teacher) }
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:member) { FactoryBot.create(:member, user:, workshop:, role: :teacher, status: :active) }
  let(:start) { Time.now }
  let!(:schedule1) { FactoryBot.create(:schedule, workshop:, author: user, start:) }
  let(:pattern) { :no_repeat }
  let!(:setting) { FactoryBot.create(:schedule_setting, schedule: schedule1, pattern:) }
  let(:params) do
    {
      workshop_id: workshop.id,
      start: Date.today.beginning_of_week.to_datetime.to_i,
      finish: Date.today.next_week.beginning_of_week.to_datetime.to_i
    }
  end
  let(:service) { described_class.new(user, params) }
  describe '#call' do
    context 'no_repeat' do
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

    context 'this_day_next_week' do
      let(:pattern) { :this_day_next_week }
      context 'range in the future' do
        let(:start) {
          result = 1.week.ago
          result.change(hour: 10, min: 0, sec: 0)
          result
        }

        context 'in range' do
          let(:start) { Time.now }

          it 'returns success' do
            result = service.call
            expect(service.success?).to eq(true)
            expect(result.length).to eq(1)
          end
        end

        context 'no duplicate' do
          it 'returns success' do
            result = service.call
            expect(service.success?).to eq(true)
            expect(result.length).to eq(1)
          end
        end

        context 'duplicate' do
          before do
            clone = schedule1.dup
            clone.start = start + 1.week
            clone.parent_id = schedule1.id
            clone.save!
          end

          after do
            # Timecop.return
          end

          it 'returns success' do
            result = service.call
            expect(service.success?).to eq(true)
            expect(result.length).to eq(1)
            expect(Schedule.last.parent_id).to eq(schedule1.id)
          end

        end
      end

      context 'range in the past' do
        let(:start) { 1.week.from_now }

        it 'returns success' do
          result = service.call
          expect(service.success?).to eq(true)
          expect(result.length).to eq(0)
        end
      end
    end
  end
end
