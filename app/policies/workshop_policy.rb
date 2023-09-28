class WorkshopPolicy < ApplicationPolicy
  def is_member?
    Member.where(user_id: current_user.id, workshop_id: current_workshop.id).present?
  end
end
