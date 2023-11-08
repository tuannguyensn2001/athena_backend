require 'rails_helper'

RSpec.describe SyncTargetObjectJob, type: :job do
  let!(:workshop) { FactoryBot.create(:workshop) }

  context 'target object is not existed' do
    it 'should create new target object' do
      SyncTargetObjectJob.perform_now('Workshop', workshop.id)
      target_object = TargetObject.first
      expect(target_object).to be_present
      expect(target_object.workshop?).to be_truthy
      expect(target_object.target_id).to eq(workshop.id)
      expect(target_object.properties.deep_symbolize_keys).to eq(WorkshopSerializer.new(workshop).as_json)
    end
  end
end
