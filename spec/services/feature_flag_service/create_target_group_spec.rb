require 'rails_helper'

describe FeatureFlagService::CreateTargetGroup do
  let(:params) do
    {
      name: 'Test target group',
      target_type: 'workshop',
      description: 'Test description',
      conditions: {
        "operator": "and",
        "list": [
          {
            "field": "subscription_plan",
            "operator": "=",
            "value": "free"
          }
        ]
      }
    }
  end
  let(:service) { described_class.new(params) }

  context 'when params are valid' do
    it 'should create in db' do
      service.call
      expect(TargetGroup.count).to eq(1)
      expect(service.success?).to eq(true)
    end
  end

  context 'target group existed' do
    before do
      FactoryBot.create(:target_group, name: params[:name], target_type: params[:target_type], conditions: params[:conditions])
    end

    it 'should return error' do
      service.call
      expect(service.success?).to eq(false)
    end
  end

  context 'conditions is invalid' do
    before do
      params[:conditions] = {}
    end

    it 'should return error' do
      service.call
      expect(service.success?).to eq(false)
    end
  end
end
