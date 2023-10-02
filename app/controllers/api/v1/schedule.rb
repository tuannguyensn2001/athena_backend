module Api::V1
  class Schedule < Grape::API
    version 'v1', using: :path

    include Api::Authentication

    before do
      authenticate!
    end

    resources :schedules do
      desc 'Create schedule in workshop'
      params do
        requires :name, type: String
        requires :workshop_id, type: Integer
        requires :channel, type: String
        requires :start, type: Integer
        optional :minutes, type: Integer, default: 0
        optional :approve_update_status_automatically, type: Boolean, default: false
      end
      post do
        service = ScheduleService::TeacherCreate.new(current_user, params)
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
