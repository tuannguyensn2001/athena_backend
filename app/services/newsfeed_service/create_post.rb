# frozen_string_literal: true

module NewsfeedService
  class CreatePost < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless member?

      post = Post.new(
        user_id: @current_user&.id,
        workshop_id: @params[:workshop_id],
        content: @params[:content]
      )

      post.save!

      CreateNewPostJob.perform_later(post.id)

      post
    rescue StandardError => e
      add_error e.message
    end
  end
end
