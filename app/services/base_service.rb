# frozen_string_literal: true

class BaseService
  attr_reader :current_user, :current_workshop, :errors

  def initialize(*_args)
    @errors = []
    @current_user = nil
  end

  def set_auth_context(auth_context)
    @auth_context = auth_context
    @current_workshop = auth_context.workshop
    @current_user = auth_context.user
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
    return @auth_context if defined? @auth_context

    AuthContext.new(user: current_user, workshop: current_workshop)
  end

  def workshop_policy
    @workshop_policy ||= WorkshopPolicy.new(auth_context)
  end

  def member?
    workshop_policy.member?
  end

  def teacher_in_workshop?
    workshop_policy.teacher?
  end
end
