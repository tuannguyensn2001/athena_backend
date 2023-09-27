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
end
