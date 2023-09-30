require "rails_helper"

describe MemberService::RemoveStudent do
  let(:teacher) { FactoryBot.create(:user, role: :teacher) }
  let(:student) { FactoryBot.create(:user, role: :student) }
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:member_1) { FactoryBot.create(:member, user: teacher, workshop: workshop, role: :teacher, status: :active) }
  let!(:member_2) { FactoryBot.create(:member, user: student, workshop: workshop, role: :student, status: :active) }
  let(:params) do
    {
      workshop_id: workshop.id,
      student_id: student.id
    }
  end
  let(:service) {described_class.new(teacher,params)}

  describe "#call" do
    context "role valid" do
      it "returns success" do
        service.call
        expect(service.success?).to eq true
        expect(Member.count).to eq 1
      end
    end
  end
end
