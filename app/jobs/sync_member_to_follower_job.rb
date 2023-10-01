# frozen_string_literal: true

class SyncMemberToFollowerJob < ApplicationJob
  queue_as :default

  def perform(attributes)
    # Do something later
    attributes = attributes.deep_symbolize_keys

    member_id = attributes[:id]
    member = Member.where(id: member_id).first
    if member.blank?
      Follower.where(
        user_id: attributes[:user_id],
        followable_type: Workshop.name,
        followable_id: attributes[:workshop_id]
      ).destroy_all
      return
    end
    workshop = member.workshop
    if member.pending?
      Follower.where(
        user_id: member.user_id,
        followable: workshop
      ).destroy_all
      return
    end
    follower = Follower.find_by(
      user_id: member.user_id,
      followable: workshop
    )
    return unless follower.blank?

    Follower.create(
      user_id: member.user_id,
      followable: workshop
    )
  end
end
