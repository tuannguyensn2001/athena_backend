# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def teacher?(user = current_user)
    user&.teacher?
  end

  def student?(user = current_user)
    user&.student?
  end
end
