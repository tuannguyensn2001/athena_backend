# frozen_string_literal: true
require 'rails_helper'

describe FeatureFlagService::AddObjectToFeatureFlag do
  let(:feature_flag) {
 FactoryBot.create(:feature_flag, code: 'exercise', target_type: 'workshop', state: 'open_beta', conditions: nil) }
  let(:target_object) { FactoryBot.create(:target_object, target_type: 'workshop') }
  let(:params) do
    {
      feature_flag_id: feature_flag.id,
      target_object_id: target_object.id
    }
  end
  let(:service) { described_class.new(params) }

  context 'feature flag and target object has different target type' do
    let(:target_object) { FactoryBot.create(:target_object, target_type: 'user') }

    it 'should return errors' do
      service.call
      expect(service.error?).to eq(true)
      expect(service.errors.first).to eq('invalid target type')
    end
  end

  context 'added' do
    let!(:feature_flag_object) { FactoryBot.create(:feature_flag_object, feature_flag:, target_object:) }

    it 'should return errors' do
      service.call
      expect(service.error?).to eq(true)
      expect(service.errors.first).to eq('added')
    end
  end

  context 'params is valid' do
    it 'should return success' do
      service.call
      expect(service.error?).to eq(false)
      expect(FeatureFlagObject.count).to eq(1)
      expect(FeatureFlagObject.first.feature_flag_id).to eq(feature_flag.id)
      expect(FeatureFlagObject.first.target_object_id).to eq(target_object.id)
    end
  end

  context 'feature flag is released' do
    before do
      feature_flag.update(state: 'released')
    end

    it 'should return errors' do
      service.call
      expect(service.error?).to eq(true)
      expect(service.errors.first).to eq('feature flag released')
    end
  end
end


