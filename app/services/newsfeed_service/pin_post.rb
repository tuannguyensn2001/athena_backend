# frozen_string_literal: true

module NewsfeedService
  class PinPost < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      post = Post.find(@params[:post_id])
      @current_workshop = post.workshop
      return add_error 'forbidden' unless teacher_in_workshop?

      post.pinned_at = Time.now
      post.save!
    rescue StandardError => e
      add_error e.message
    end
  end
end
