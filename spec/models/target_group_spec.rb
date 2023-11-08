require 'rails_helper'

RSpec.describe TargetGroup, type: :model do
  describe '#validate_condition' do
    context 'payload is not valid' do
      it 'should return false' do
        target_group = TargetGroup.new(conditions: { 'operator' => 'and' }, name: 'name', target_type: 'workshop')
        expect(target_group.valid?).to eq(false)
      end
    end

    context 'payload is valid' do
      let(:payload) {
        {
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
      it 'should return true' do
        target_group = TargetGroup.new(conditions: payload, name: 'name', target_type: 'workshop')
        expect(target_group.valid?).to eq(true)
      end
    end
  end
end
