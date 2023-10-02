class UpdateStatusScheduleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.info "update_status"
  end
end
