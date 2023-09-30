module MemberService
  class RejectStudentPending < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error "forbidden" unless is_teacher_in_workshop?

      if reject_all?
        reject_all
      else
        reject_one
      end

    rescue StandardError => e
      return add_error e.message
    end

    private

    def reject_all
      Member.student.pending.where(workshop_id: @current_workshop.id).destroy_all
    end

    def reject_one
      Member.student.pending.where(user_id: @params[:student_id], workshop_id: @current_workshop.id).destroy_all
    end

    def reject_all?
      @params[:reject_all]
    end
  end

end
