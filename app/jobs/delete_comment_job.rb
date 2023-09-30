class DeleteCommentJob < ApplicationJob
  queue_as :default

  def perform(post_id, comment_id)
    # Do something later
    Pusher.trigger("newsfeed-post-#{post_id}", "delete-comment", comment_id)
  end
end
