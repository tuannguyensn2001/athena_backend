# frozen_string_literal: true

class BaseService
  attr_reader :current_user, :current_workshop, :errors

  def initialize(*_args)
    @errors = []
    @current_user = nil
  end

  def add_error(error)
    if error.is_a?(Array)
      error.each do |e|
        @errors << e
      end
      return
    end
    @errors << error
  end

  def error?
    @errors.any?
  end

  def success?
    !error?
  end

  def call
    raise NotImplementedError
  end

  private

  def auth_context
    AuthContext.new(user: current_user, workshop: current_workshop)
  end

  def workshop_policy
    @workshop_policy ||= WorkshopPolicy.new(auth_context)
  end

  def is_member?
    workshop_policy.is_member?
  end

  def is_teacher_in_workshop?
    workshop_policy.is_teacher?
  end
end
