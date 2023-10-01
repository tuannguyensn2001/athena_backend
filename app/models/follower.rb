# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user
end
