require 'rails_helper'

describe FeatureFlagService::On do
  let(:workshop) { FactoryBot.create(:workshop) }
  let(:target_object) {
    FactoryBot.create(:target_object, target_type: 'workshop', properties: WorkshopSerializer.new(workshop).as_json, target_id: workshop.id) }
  let(:feature_flag) { FactoryBot.create(:feature_flag, code: 'test', state: 'open_beta', target_type: 'workshop') }
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
          let!(:feature_flag_object) { FactoryBot.create(:feature_flag_object, feature_flag: feature_flag, target_object: target_object) }
          it 'should return true' do
            expect(service.call).to eq(true)
          end
        end
      end
    end
  end

end
