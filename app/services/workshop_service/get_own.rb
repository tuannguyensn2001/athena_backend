# frozen_string_literal: true

module WorkshopService
  class GetOwn < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      ids = current_user&.members&.where(members: { status: :active })&.pluck(:workshop_id)
      Workshop.where(id: ids, is_show: @params[:is_show]).order(id: :desc)
    rescue StandardError => e
      add_error(e)
    end
  end
end
