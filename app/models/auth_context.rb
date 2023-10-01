# frozen_string_literal: true

class AuthContext
  attr_reader :user, :workshop

  def initialize(user: nil, workshop: nil)
    @user = user
    @workshop = workshop
  end
end
