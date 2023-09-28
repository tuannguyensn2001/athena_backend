require "rails_helper"

describe WorkshopService::GetOwn do
  let(:user) { FactoryBot.create(:user, role: :teacher) }
  let(:workshop) { FactoryBot.create(:workshop,code: "1") }
  let!(:member) { FactoryBot.create(
    :member,
    user_id: user.id,
    workshop_id: workshop.id,
    role: user.role,
    status: :active
  ) }
  let(:second_workshop) { FactoryBot.create(:workshop, name: "workshop 2",code: "2") }
  let!(:member2) { FactoryBot.create(:member, user_id: user.id, workshop_id: second_workshop.id, role: user.role, status: :pending) }
  let(:service) { described_class.new(user) }

  describe "#call" do
    context "valid" do
      it "returns success" do
        result = service.call
        expected = [workshop]
        expect(result).to match_array(expected)
      end
    end
  end
end