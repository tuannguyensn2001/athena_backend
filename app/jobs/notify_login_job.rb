class NotifyLoginJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.info "user login"
  end
end
