# frozen_string_literal: true

module NewsfeedService
  class GetCommentInPost < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      post = Post.find @params[:post_id]
      @current_workshop = post.workshop
      return add_error 'forbidden' unless member?

      post.comments.includes(user: :profile).order(id: :desc)
    rescue StandardError => e
      add_error e.message
    end
  end
end
