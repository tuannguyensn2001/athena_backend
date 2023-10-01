# frozen_string_literal: true

module NotificationService
  class GetOwn < BaseService
    def initialize(current_user)
      super
      @current_user = current_user
    end

    def call
      Notification.where(
        to_user_id: @current_user&.id,
        read_at: nil
      )
    end
  end
end
