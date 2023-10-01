# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def need_verified?
    false
  end
end
