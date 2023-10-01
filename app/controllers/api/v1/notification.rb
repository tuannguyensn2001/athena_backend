# frozen_string_literal: true

module Api
  module V1
    class Notification < Grape::API
      version 'v1', using: :path

      include Api::Authentication

      before do
        authenticate!
      end

      resources :notifications do
        resources :workshops do
          desc 'Teacher notify to workshop'
          params do
            requires :content, type: String
            requires :workshop_id, type: Integer
          end
          post do
            service = NotificationService::TeacherNotifyToWorkshop.new(current_user, params)
            service.call
            if service.success?
              {
                message: 'success'
              }
            else
              error!({ message: service.errors.first }, 500)
            end
          end

          desc 'Get notification in workshop'
          params do
            requires :workshop_id, type: Integer
          end
          get ':workshop_id' do
            service = NotificationService::GetNotificationInWorkshop.new(current_user, params)
            result = service.call
            if service.success?
              {
                message: 'success',
                data: result
              }
            else
              error!({ message: service.errors.first }, 500)
            end
          end
        end

        desc 'Get number unseen'
        get :unseen do
          service = NotificationService::GetNumberUnseen.new(current_user)
          result = service.call
          if service.success?
            {
              message: 'success',
              data: result
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end

        desc 'Get own notifications'
        get do
          service = NotificationService::GetOwn.new(current_user)
          result = service.call
          if service.success?
            {
              message: 'success',
              data: result
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end
      end
    end
  end
end
