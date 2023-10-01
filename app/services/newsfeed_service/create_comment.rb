# frozen_string_literal: true

module NewsfeedService
  class CreateComment < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      post = Post.find @params[:post_id]
      @current_workshop = post.workshop
      return add_error 'forbidden' unless is_member?

      comment = Comment.new(
        user_id: @current_user&.id,
        post_id: @params[:post_id],
        content: @params[:content]
      )
      comment.save!

      CreateNewCommentJob.perform_later(comment.id)
    rescue StandardError => e
      add_error e.message
    end
  end
end
