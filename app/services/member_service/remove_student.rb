# frozen_string_literal: true

module MemberService
  class RemoveStudent < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless is_teacher_in_workshop?

      member = Member.find_by(
        user_id: @params[:student_id],
        workshop_id: @current_workshop.id
      )
      member.destroy!
    rescue StandardError => e
      add_error e.message
    end
  end
end
