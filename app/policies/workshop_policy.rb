# frozen_string_literal: true

class WorkshopPolicy < ApplicationPolicy
  def member?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id).present?
  end

  def teacher?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id, role: :teacher).present?
  end

  def student?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id, role: :student).present?
  end
end
