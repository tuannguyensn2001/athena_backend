module FeatureFlagService
  class On < BaseService
    def initialize(code, context)
      super
      @code = code
      set_auth_context(context)
    end

    def call
      feature_flag = FeatureFlag.where(code: @code).first
      return false unless feature_flag

      target_object = get_target_object(feature_flag)
      return add_error('Target object not found') unless target_object.present?

      unless feature_flag.released?
        return true if FeatureFlagObject.where(
          feature_flag_id: feature_flag.id,
          target_object_id: target_object.id
        ).first.present?
      end

      false
    end

    def get_target_object(feature_flag)
      if feature_flag.workshop?
        return TargetObject.where(
          target_type: 'workshop',
          target_id: @current_workshop.id
        ).first
      end

      if feature_flag.user?
        return TargetObject.where(
          target_type: 'user',
          target_id: @current_user.id
        ).first
      end

      raise StandardError, 'Target type not found'
    end
  end
end

