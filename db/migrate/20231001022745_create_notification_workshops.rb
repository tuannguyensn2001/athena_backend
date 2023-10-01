# frozen_string_literal: true

class CreateNotificationWorkshops < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_workshops do |t|
      t.string :content
      t.integer :workshop_id
      t.integer :user_id
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
