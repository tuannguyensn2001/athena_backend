# frozen_string_literal: true

module MemberService
  class StudentRequestToEnroll < BaseService
    def initialize(current_user, params)
      super
      @current_user = current_user
      @params = params
    end

    def call
      @current_workshop = Workshop.find(@params[:workshop_id])
      return add_error 'forbidden' unless student?
      return add_error 'locked' if @current_workshop.is_lock?

      member = Member.where(
        workshop_id: @current_workshop.id,
        user_id: current_user&.id
      ).first
      existed = member_existed_in_workshop?(member)
      return if existed

      save_member!
    rescue StandardError => e
      add_error e.message
    end

    def student?
      RolePolicy.new.student?(current_user)
    end

    def member_existed_in_workshop?(member)
      return false unless member.present?

      # return true  add_error 'student joined' if member.active?
      if member.active?
        add_error 'student joined'
        return true
      end

      # add_error 'student already requested' if member.pending?
      return unless member.pending?

      add_error 'student already requested'
      true
    end

    def save_member!
      member = Member.new(
        workshop_id: @current_workshop.id,
        user_id: current_user&.id,
        role: :student,
        status: @current_workshop.approve_student? ? :pending : :active
      )

      member.save!
    end
  end
end
