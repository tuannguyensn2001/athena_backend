# frozen_string_literal: true

class CreateNewPostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    # Do something later
    post = Post.includes(user: :profile).find(post_id)
    payload = PostSerializer.new(post)
    code = post.workshop.code
    Pusher.trigger "newsfeed-workshop-#{code}", 'new-post', payload
  end
end
