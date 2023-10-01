# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :workshop_id
      t.string :role
      t.string :status

      t.timestamps
    end
  end
end
