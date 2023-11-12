module FeatureFlagService
  class AddObjectToFeatureFlag < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      feature_flag = FeatureFlag.find(@params[:feature_flag_id])

      return add_error('feature flag released') if feature_flag.released?

      target_object_id = @params[:target_object_id]
      target_object = TargetObject.find(target_object_id)
      return add_error('invalid target type') if target_object.target_type != feature_flag.target_type

      feature_flag_object = FeatureFlagObject.where(
        feature_flag_id: @params[:feature_flag_id],
        target_object_id: target_object.id
      ).first
      return add_error 'added' if feature_flag_object.present?

      feature_flag_object = FeatureFlagObject.new(
        feature_flag_id: @params[:feature_flag_id],
        target_object_id:
      )
      add_error(feature_flag_object.errors.full_messages) unless feature_flag_object.save
    end
  end
end
