# frozen_string_literal: true

module NewsfeedService
  class GetPostInWorkshop < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find @params[:workshop_id]
      return add_error 'forbidden' unless is_member?

      query = @current_workshop.posts.includes(user: :profile).limit(@params[:limit]).order(id: :desc)
      query = query.where('id < ?', @params[:cursor]) if (@params[:cursor]).positive?
      query = query.where.not(pinned_at: nil) if @params[:is_pinned]

      next_cursor = if !query.empty?
                      query.last.id
                    else
                      0
                    end
      {
        data: query,
        meta: {
          next_cursor:,
          total: query.length
        }
      }
    end
  end
end
