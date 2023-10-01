# frozen_string_literal: true

module MemberService
  class ApproveStudentPending < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless teacher_in_workshop?

      if approve_all?
        approve_all
      else
        approve_one
      end
    rescue StandardError => e
      add_error e.message
    end

    private

    def approve_all
      Member.student.pending.where(workshop_id: @current_workshop.id).update(status: :active)
    end

    def approve_one
      Member.student.pending.where(user_id: @params[:student_id],
                                   workshop_id: @current_workshop.id).update(status: :active)
    end

    def approve_all?
      @params[:approve_all]
    end
  end
end
