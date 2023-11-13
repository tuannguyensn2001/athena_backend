require 'rails_helper'

describe FeatureFlagService::On do
  let(:workshop) { FactoryBot.create(:workshop) }
  let!(:target_object) do
    FactoryBot.create(:target_object, target_type: 'workshop', properties: WorkshopSerializer.new(workshop).as_json,
                      target_id: workshop.id)
  end
  let(:conditions) do
    {
      "if": [
        {
          "operator": 'and',
          "list": ['subscription_plan'],
          "value": false
        }
      ],
      "else": true
    }
  end
  let!(:attribute) do
    FactoryBot.create(
      :custom_attribute,
      name: 'subscription_plan',
      target_type: 'workshop',
      data_type: 'string',
      visible: true
    )
  end
  let!(:attribute2) do
    FactoryBot.create(
      :custom_attribute,
      name: 'id',
      target_type: 'workshop',
      data_type: 'integer',
      visible: true
    )
  end
  let!(:target_group) do
    FactoryBot.create(:target_group,
                      name: 'subscription_plan',
                      target_type: 'workshop',
                      conditions: { "operator": 'and',
                                    "list": [{ "field": 'subscription_plan', "operator": '=', "value": 'free' },
                                             { "field": 'id', "operator": '>', "value": '0' }] }
    )
  end
  let(:feature_flag) do
    FactoryBot.create(:feature_flag, code: 'test', state: 'open_beta', target_type: 'workshop', conditions:)
  end
  let(:auth_context) { AuthContext.new(workshop:) }
  let(:service) { described_class.new(feature_flag.code, auth_context) }

  describe '#call' do
    context 'feature flag is released' do
      before do
        feature_flag.update(state: 'released')
      end

      it 'should return false' do
        expect(service.call).to eq(false)
      end
    end

    context 'code is not valid' do
      let(:service) { described_class.new('invalid', auth_context) }

      it 'should return false' do
        expect(service.call).to eq(false)
      end
    end

    context 'feature flag is beta' do
      context 'code is valid' do
        context 'target object added to feature flag' do
          let!(:feature_flag_object) do
            FactoryBot.create(:feature_flag_object, feature_flag: feature_flag, target_object: target_object)
          end
          it 'should return true' do
            expect(service.call).to eq(true)
          end
        end
      end
    end
  end

end
