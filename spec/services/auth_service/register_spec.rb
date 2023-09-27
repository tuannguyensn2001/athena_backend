require "rails_helper"

describe AuthService::Register do
  let(:params) do
    {
      :phone => "0984565910",
      :email => "tuannguyensn2001a@gmail.com",
      :password => "java2001",
      :role => "teacher",
      :username => "Tuan Nguyen"
    }
  end
  let(:service) { described_class.new(params) }

  describe "#call" do
    context "user hasn't existed" do
      it "returns success" do
        service.call
        expect(service.success?).to eq(true)
        expect(User.count).to eq(1)
        expect(Profile.count).to eq(1)
        user = User.first
        expect(user.phone).to eq(params[:phone])
        expect(user.email).to eq(params[:email])
        expect(user.role).to eq(params[:role])
        expect(user.profile.username).to eq(params[:username])
        expect(user.password.present?).to eq(true)

      end
    end

    context "user existed" do
      before do
        FactoryBot.create(:user, phone: params[:phone])
      end

      it "returns error" do
        service.call
        expect(service.error?).to eq(true)
      end
    end
  end
end
