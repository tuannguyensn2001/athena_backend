module NotificationService
  class GetNumberUnseen < BaseService
    def initialize(current_user)
      super
      @current_user = current_user
    end

    def call
      Notification.where(
        to_user_id: @current_user&.id,
        read_at: nil
      ).count
    end
  end
end
