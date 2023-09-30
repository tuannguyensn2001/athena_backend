module Api::V1
  class Permission < Grape::API
    version 'v1', using: :path

    include Api::Authentication

    before do
      authenticate!
    end

    resources :permissions do
      desc 'Get permissions sidebar in workshop'
      params do
        requires :workshop_id, type: Integer
      end
      get "workshops/:workshop_id/sidebar" do
        service = PermissionService::GetSidebar.new(current_user, params)
        result = service.call
        if service.success?
          {
            message: "success",
            data: result
          }
        else
          error!({ message: service.errors.first }, 500)
        end
      end
    end
  end
end
