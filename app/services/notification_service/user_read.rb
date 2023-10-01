# frozen_string_literal: true

module NotificationService
  class UserRead < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      list_id = @params[:list_id]
      list_id.each do |id|
        Notification.where(id:).update(read_at: Time.now)
      end
    rescue StandardError => e
      add_error e.message
    end
  end
end
