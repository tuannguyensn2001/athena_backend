# frozen_string_literal: true

class MemberPolicy < ApplicationPolicy
  def use?
    WorkshopPolicy.new(@context).is_teacher?
  end
end
