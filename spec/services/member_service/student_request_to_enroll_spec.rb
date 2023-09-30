require "rails_helper"

describe MemberService::StudentRequestToEnroll do
  let(:student) { FactoryBot.create(:user, role: :student) }
  let(:is_lock) { false }
  let(:approve_student) { false }
  let(:workshop) { FactoryBot.create(:workshop, is_lock: is_lock, approve_student: approve_student) }
  let(:params) do
    {
      workshop_id: workshop.id
    }
  end
  let(:service) { described_class.new(student, params) }

  describe "#call" do
    context "user is teacher" do
      before do
        student.teacher!
      end
      it "returns error" do
        service.call
        expect(service.error?).to eq true
      end
    end

    context "user is student" do
      context "workshop is locked" do
        let(:is_lock) { true }
        it "returns error" do
          service.call
          expect(service.error?).to eq true
        end
      end

      context "workshop is not locked" do
        context "member existed " do
          let!(:member) { FactoryBot.create(:member, user_id: student.id, workshop_id: workshop.id, role: :student) }
          it "returns error" do
            service.call
            expect(service.error?).to eq true
          end
        end

        context "member hasn't existed " do
          context "workshop doesn't approve student" do
            it "returns success" do
              service.call
              expect(service.success?).to eq true
              expect(Member.first.active?).to eq true
            end
          end

          context "workshop approves student" do
            let(:approve_student) { true }
            it "returns success" do
              service.call
              expect(service.success?).to eq true
              expect(Member.first.pending?).to eq true
            end
          end
        end
      end
    end
  end
end
