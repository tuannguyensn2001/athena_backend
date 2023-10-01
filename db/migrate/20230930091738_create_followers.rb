# frozen_string_literal: true

class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.references :followable, polymorphic: true, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
