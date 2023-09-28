module Api::V1
  class Workshop < Grape::API
    version 'v1', using: :path

    include Api::Authentication

    resources :workshops do
      before do
        authenticate!
      end

      desc "Create a workshop"
      params do
        requires :name, type: String, desc: "Workshop name"
        optional :private_code, type: String, desc: "Private code", default: nil
        optional :approve_student, type: Boolean, desc: "Approve student", default: false
        optional :approve_show_score, type: Boolean, desc: "Approve show score", default: false
        optional :prevent_student_leave, type: Boolean, desc: "Prevent student leave", default: false
        optional :disable_newsfeed, type: Boolean, desc: "Disable newsfeed", default: false
        optional :limit_policy_teacher, type: Boolean, desc: "Limit policy teacher", default: false
        requires :subject, type: String, desc: "Subject"
        requires :grade, type: String, desc: "Grade"
      end

      post do
        service = WorkshopService::Create.new(current_user, params)
        service.call
        if service.success?
          {
            message: "success"
          }
        else
          error!({ message: service.errors }, 400)
        end
      end

      desc 'Get Own Workshop'
      params do
        optional :is_show, type: Boolean, default: true, desc: 'Is show'
      end

      get :own do
        service = WorkshopService::GetOwn.new(current_user, params)
        result = service.call
        if service.success?
          {
            message: "success",
            data: result
          }
        else
          error!({ message: "internal server" }, 500)
        end
      end

      desc "Get By Code"
      params do
        requires :code, type: String, desc: 'Code'
      end

      get 'code/:code' do
        service = WorkshopService::GetByCode.new(current_user, params)
        result = service.call

        if service.success?
          {
            message: "success",
            data: result
          }
        else
          error!({ message: service.errors }, 500)
        end
      end

    end
  end
end
