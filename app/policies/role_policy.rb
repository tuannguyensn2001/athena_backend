# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def is_teacher?(user = current_user)
    user&.teacher?
  end

  def is_student?(user = current_user)
    user&.student?
  end
end
