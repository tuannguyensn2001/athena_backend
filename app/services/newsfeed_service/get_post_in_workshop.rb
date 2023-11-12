# frozen_string_literal: true

module NewsfeedService
  class GetPostInWorkshop < BaseService
    def initialize(auth_context, params)
      super
      @params = params
      set_auth_context(auth_context)
    end

    def call
      return add_error 'forbidden' unless member?

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
