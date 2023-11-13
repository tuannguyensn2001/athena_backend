module Api
  module V1
    class FeatureFlag < Grape::API
      include Api::Authentication

      version 'v1', using: :path

      resource :feature_flag do
        desc 'Create custom attribute'
        params do
          requires :name, type: String, desc: 'Name of the attribute'
          requires :target_type, type: String, desc: 'Target type of the attribute'
          requires :data_type, type: String, desc: 'Data type of the attribute'
          optional :description, type: String, desc: 'Description of the attribute'
          optional :visible, type: Boolean, default: true, desc: 'Visibility of the attribute'
        end
        post :custom_attribute do
          service = FeatureFlagService::CreateCustomAttribute.new(params)
          service.call
          if service.success?
            {
              message: 'success'
            }
          else
            error!({ message: service.errors.first }, 400)
          end
        end

        desc 'Get custom attributes'
        params do
          optional :visible, type: Boolean, desc: 'Visibility of the attribute'
        end
        get :custom_attribute do
          result = CustomAttribute
          result = result.where(visible: params[:visible]) unless params[:visible].nil?
          output = result.order(:id).all || []

          {
            message: 'success',
            data: output
          }
        end

        desc 'Get detail custom attribute'
        params do
          requires :id, type: Integer, desc: 'Id of the attribute'
        end
        get 'custom_attribute/:id' do
          result = CustomAttribute.find(params[:id])

          {
            message: 'success',
            data: result
          }
        end

        desc 'Update custom attribute'
        params do
          requires :id, type: Integer, desc: 'Id of the attribute'
          requires :description, type: String, desc: 'Description of the attribute'
        end
        put 'custom_attribute/:id' do
          attribute = CustomAttribute.find(params[:id])
          attribute.update(description: params[:description])
          {
            message: 'success'
          }
        end

        desc 'Get operator'
        params do
          requires :data_type, type: String, desc: 'Type of the operator'
        end
        get :operators do
          result = Operator.get_operator(params[:data_type])

          {
            message: 'success',
            data: result
          }
        end

        desc 'Create target group'
        params do
          requires :name, type: String, desc: 'Name of the target group'
          requires :target_type, type: String, desc: 'Target type of the target group'
          optional :description, type: String, desc: 'Description of the target group'
          requires :conditions, type: Hash, desc: 'Conditions of the target group'
        end
        post :target_groups do
          service = FeatureFlagService::CreateTargetGroup.new(params)
          service.call
          if service.success?
            {
              message: 'success'
            }
          else
            error!({ message: service.errors.first }, 400)
          end
        end

        desc 'Create feature flag'
        params do
          requires :code, type: String, desc: 'Code of the feature flag'
          requires :state, type: String, desc: 'Status of the feature flag'
          requires :target_type, type: String, desc: 'Target type of the feature flag'
          optional :conditions, type: Hash, desc: 'Conditions of the feature flag'
        end
        post do
          service = FeatureFlagService::CreateFeatureFlag.new(params)
          service.call
          if service.success?
            {
              message: 'success'
            }
          else
            error!({ message: service.errors.first }, 400)
          end
        end
      end
    end
  end
end
