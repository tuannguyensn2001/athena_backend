# frozen_string_literal: true

module MemberService
  class GetStudentInWorkshop < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless teacher_in_workshop?

      ids = Member.select('user_id').student.where(workshop_id: @current_workshop.id,
                                                   status: @params[:status]).pluck(:user_id)
      User.where(id: ids)
    rescue StandardError => e
      add_error e.message
    end
  end
end
