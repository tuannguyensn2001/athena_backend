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
        requires :pattern, type: String
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

      desc 'Get schedule in workshop'
      params do
        requires :workshop_id, type: Integer
        requires :start, type: Integer
        requires :finish, type: Integer
      end
      get 'workshops/:workshop_id' do
        service = ScheduleService::GetInWorkshop.new(current_user, params)
        result = service.call
        if service.success?
          {
            message: 'success',
            data: ActiveModelSerializers::SerializableResource.new(result, each_serializer: ScheduleSerializer)
          }
        else
          error!({ message: service.errors.first }, 400)
        end
      end

      desc 'Student Attendance'
      params do
        requires :schedule_id, type: Integer
        requires :student_id, type: Integer
      end
      post :attendances do
        service = ScheduleService::StudentAttendance.new(current_user, params)
        service.call
        if service.success?
          {
            message: 'success'
          }
        else
          error!({ message: service.errors.first }, 400)
        end
      end

      desc 'Finish'
      params do
        requires :schedule_id, type: Integer
      end

      post :finish do
        service = ScheduleService::Finish.new(current_user, params)
        service.call
        if service.success?
          {
            message: 'success'
          }
        else
          error!({ message: service.errors.first }, 400)
        end
      end

      desc 'Get members'
      params do
        requires :schedule_id, type: Integer
      end
      get ':schedule_id/members' do
        service = ScheduleService::GetMembers.new(current_user, params)
        result = service.call
        if service.success?
          {
            message: 'success',
            data: {
              attendance: ActiveModelSerializers::SerializableResource.new(result[:attendance], each_serializer: UserSerializer),
              not_attendance: ActiveModelSerializers::SerializableResource.new(result[:not_attendance], each_serializer: UserSerializer)
            }
          }
        else
          error!({ message: service.errors.first }, 400)
        end
      end

      desc 'Get schedule'
      params do
        requires :schedule_id, type: Integer
      end

      get ':schedule_id' do
        service = ScheduleService::GetDetail.new(current_user, params)
        result = service.call
        if service.success?
          {
            message: 'success',
            data: result
          }
        else
          error!({ message: 'Schedule not found' }, 400)
        end
      end
    end
  end
end
