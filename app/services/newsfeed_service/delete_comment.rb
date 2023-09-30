module NewsfeedService
  class DeleteComment < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      comment = Comment.find @params[:comment_id]
      @current_workshop = comment.post.workshop
      return add_error "forbidden" unless is_member?

      comment.delete

      DeleteCommentJob.perform_later(comment.post.id, comment.id)

    rescue StandardError => e
      return add_error e.message
    end
  end
end
