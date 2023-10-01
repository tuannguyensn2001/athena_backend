# frozen_string_literal: true

class CreateNewCommentJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.includes(user: :profile).includes(:post).find comment_id
    post = comment.post
    payload = CommentSerializer.new(comment)

    Pusher.trigger("newsfeed-post-#{post.id}", 'new-comment', payload)
  end
end
