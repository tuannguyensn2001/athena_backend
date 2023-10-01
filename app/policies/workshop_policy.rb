# frozen_string_literal: true

class WorkshopPolicy < ApplicationPolicy
  def is_member?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id).present?
  end

  def is_teacher?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id, role: :teacher).present?
  end
end
