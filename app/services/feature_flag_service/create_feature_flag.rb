module FeatureFlagService
  class CreateFeatureFlag < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      feature_flag = FeatureFlag.new(
        code: @params[:code],
        description: @params[:description],
        state: @params[:state],
        target_type: @params[:target_type],
        conditions: @params[:conditions],
      )
      add_error(feature_flag.errors.full_messages) unless feature_flag.save
    end
  end
end
