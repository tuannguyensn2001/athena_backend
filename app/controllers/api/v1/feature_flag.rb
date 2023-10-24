module Api
  module V1
    class FeatureFlag < Grape::API
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
      end
    end
  end
end
