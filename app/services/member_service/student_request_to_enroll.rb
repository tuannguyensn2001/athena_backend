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
      return add_error 'forbidden' unless is_student?
      return add_error 'locked' if @current_workshop.is_lock?

      member = Member.where(
        workshop_id: @current_workshop.id,
        user_id: current_user&.id
      ).first
      if member.present?
        return add_error 'student joined' if member.active?
        return add_error 'student already requested' if member.pending?
      end

      member = Member.new(
        workshop_id: @current_workshop.id,
        user_id: current_user&.id,
        role: :student,
        status: @current_workshop.approve_student? ? :pending : :active
      )

      member.save!
    rescue StandardError => e
      add_error e.message
    end

    def is_student?
      RolePolicy.new.is_student?(current_user)
    end
  end
end
