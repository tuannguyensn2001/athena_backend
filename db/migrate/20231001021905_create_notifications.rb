# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.timestamp :read_at
      t.json :payload
      t.string :pattern

      t.timestamps
    end
  end
end
