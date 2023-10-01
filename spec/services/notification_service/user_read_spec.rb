require "rails_helper"

describe NotificationService::UserRead do
  let!(:teacher) { FactoryBot.create(:user, role: :teacher) }
  let!(:student) { FactoryBot.create(:user, role: :student) }
  let!(:notification) { FactoryBot.create(:notification, from_user: teacher, to_user: student, read_at: nil) }
  let!(:notification1) { FactoryBot.create(:notification, from_user: teacher, to_user: student, read_at: nil) }

  let(:params) do
    {
      list_id: [notification.id,notification1.id]
    }
  end
  let(:service) { described_class.new(student, params) }
  describe '#call' do
    context 'valid params' do
      it 'returns success' do
        service.call
        expect(service.success?).to eq true
        expect(Notification.where(to_user_id: student.id, read_at: nil).count).to eq 0
      end
    end
  end
end
