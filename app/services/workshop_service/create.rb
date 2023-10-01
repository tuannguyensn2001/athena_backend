# frozen_string_literal: true

module WorkshopService
  class Create < BaseService
    def initialize(user, params)
      super
      @current_user = user
      @params = params
    end

    def call
      return add_error('forbidden') unless is_teacher?

      ActiveRecord::Base.transaction do
        workshop = Workshop.new(
          name: @params[:name],
          thumbnail: default_thumbnail,
          private_code: @params[:private_code],
          code: generate_code,
          approve_student: @params[:approve_student],
          prevent_student_leave: @params[:prevent_student_leave],
          disable_newsfeed: @params[:disable_newsfeed],
          limit_policy_teacher: @params[:limit_policy_teacher],
          approve_show_score: @params[:approve_show_score],
          is_show: true,
          subject: @params[:subject],
          grade: @params[:grade],
          is_lock: false
        )
        workshop.save!
        member = Member.new(
          user_id: @current_user.id,
          workshop_id: workshop.id,
          role: 'teacher',
          status: :active
        )
        member.save!
      end
    rescue StandardError => e
      add_error(e.message)
    end

    private

    def is_teacher?
      RolePolicy.new(auth_context).is_teacher?
    end

    def generate_code
      letters = ('A'..'Z').to_a
      (0...5).map { letters.sample }.join
    end

    def default_thumbnail
      'https://shub-storage.sgp1.cdn.digitaloceanspaces.com/profile_images/44-01.jpg'
    end
  end
end
