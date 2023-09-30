module Api::V1
  class Member < Grape::API
    version 'v1', using: :path

    include Api::Authentication

    before do
      authenticate!
    end

    resources :members do
      resources :students do
        desc 'Add student to workshop'
        params do
          requires :phone, type: String, desc: 'Phone'
          requires :workshop_id, type: Integer, desc: 'Workshop id'
        end
        post do
          service = MemberService::AddStudent.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors }, 500)
          end
        end

        desc 'Get student in workshop'
        params do
          requires :workshop_id, type: Integer, desc: 'Workshop id'
          optional :status, type: String, default: :active
        end
        get 'workshops/:workshop_id' do
          service = MemberService::GetStudentInWorkshop.new(current_user, params)
          result = service.call
          if service.success?
            {
              message: "success",
              data: ActiveModelSerializers::SerializableResource.new(
                result,
                each_serializer: UserSerializer
              )
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end

        desc 'Student request to enroll'
        params do
          requires :workshop_id, type: Integer
        end
        post "requests/enrollment" do
          service = MemberService::StudentRequestToEnroll.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors.first }, 500)
          end

        end

        desc 'Approve student'
        params do
          requires :workshop_id, type: Integer
          requires :approve_all, type: Boolean
          optional :student_id, type: Integer, default: 0
        end
        post :approve do
          service = MemberService::ApproveStudentPending.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end

        desc 'Reject student'
        params do
          requires :workshop_id, type: Integer
          requires :reject_all, type: Boolean
          optional :student_id, type: Integer, default: 0
        end
        post :reject do
          service = MemberService::RejectStudentPending.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end

        desc 'Remove student'
        params do
          requires :workshop_id, type: Integer
          requires :student_id, type: Integer
        end
        delete do
          service = MemberService::RemoveStudent.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end
      end
    end
  end
end
