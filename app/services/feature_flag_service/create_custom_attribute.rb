module FeatureFlagService
  class CreateCustomAttribute < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      attribute = CustomAttribute.where(name: @params[:name], target_type: @params[:target_type]).first
      return add_error 'attribute already exists' if attribute.present?

      attribute = CustomAttribute.new(
        name: @params[:name],
        target_type: @params[:target_type],
        data_type: @params[:data_type],
        description: @params[:description],
        visible: @params[:visible],
      )

      attribute.save!
    end
  end
end
