module MemberService
  class AddStudent < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find @params[:workshop_id]
      return add_error "forbidden" unless is_teacher_in_workshop?
      student = User.student.find_by(
        phone: @params[:phone],
      )
      return add_error "student not valid" unless student.present?
      member = Member.student.find_by(
        user_id: student.id,
        workshop_id: @current_workshop.id,
      )
      if member.present?
        if member.active?
          return add_error "member existed"
        end
        if member.pending?
          member.active!
          return
        end
      end

      member = Member.new(
        user_id: student.id,
        workshop_id: @current_workshop.id,
        role: :student,
        status: :active
      )
      member.save!
    rescue StandardError => e
      return add_error e.message
    end
  end
end
