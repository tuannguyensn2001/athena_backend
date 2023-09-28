class AccountPolicy < ApplicationPolicy
  def need_verified?
    false
  end
end
