# frozen_string_literal: true

class DeletePostJob < ApplicationJob
  queue_as :default

  def perform(workshop_code, post_id)
    Pusher.trigger("newsfeed-workshop-#{workshop_code}", 'delete-post', post_id)
  end
end
