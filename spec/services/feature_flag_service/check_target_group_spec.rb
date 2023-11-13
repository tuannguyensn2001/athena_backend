# frozen_string_literal: true
require 'rails_helper'

describe FeatureFlagService::CheckTargetGroup do
  let(:workshop_id) { 1 }
  let!(:attribute) {
    FactoryBot.create(
      :custom_attribute,
      name: 'subscription_plan',
      target_type: 'workshop',
      data_type: 'string',
      visible: true
    )
  }
  let!(:attribute2) {
    FactoryBot.create(
      :custom_attribute,
      name: 'id',
      target_type: 'workshop',
      data_type: 'string',
      visible: true
    )
  }
  let(:target_object) do
    FactoryBot.create(:target_object,
                      target_type: 'workshop',
                      status: 'active',
                      target_id: workshop_id,
                      tags: nil,
                      properties: { "id": 1, "name": 'Workshop', "thumbnail": 'https://shub-storage.sgp1.cdn.digitaloceanspaces.com/profile_images/44-01.jpg', "private_code": nil, "approve_student": false, "prevent_student_leave": false, "approve_show_score": false, "disable_newsfeed": false, "limit_policy_teacher": false, "is_show": true, "subject": 'math', "grade": '6', "is_lock": false, "created_at": 1_696_343_841, "updated_at": 1_699_456_970, "subscription_plan": 'free' }

    )
  end
  let(:operator) { 'and' }
  let(:target_group) do
    FactoryBot.create(:target_group,
                      name: 'subscription_plan',
                      target_type: 'workshop',
                      conditions: { "operator": operator,
                                    "list": [{ "field": 'subscription_plan', "operator": '=', "value": 'free' },
                                             { "field": 'id', "operator": '>', "value": '0' }] }
    )
  end
  let(:service) { described_class.new(target_group, target_object) }

  describe '#call' do
    context 'when valid params' do
      it 'should return true' do
        expect(service.call).to eq(true)
      end
    end

    context 'operator is or' do
      let(:operator) { 'or' }
      let(:target_group) do
        FactoryBot.create(:target_group,
                          name: 'subscription_plan',
                          target_type: 'workshop',
                          conditions: { "operator": operator,
                                        "list": [{ "field": 'subscription_plan', "operator": '=', "value": 'free' },
                                                 { "field": 'id', "operator": '<', "value": '0' }] }
        )
      end

      it 'should return true' do
        expect(service.call).to eq(true)
      end
    end
  end

end
