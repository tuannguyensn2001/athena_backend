module FeatureFlagService
  class CreateTargetGroup < BaseService
    def initialize(params)
      super
      @params = params
    end

    def call
      target_group = TargetGroup.new(
        name: @params[:name],
        target_type: @params[:target_type],
        description: @params[:description],
        conditions: @params[:conditions]
      )

      add_error(target_group.errors) unless target_group.save
    end
  end
end
