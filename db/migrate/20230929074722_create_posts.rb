# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :user_id
      t.integer :workshop_id
      t.integer :pinned_at
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
