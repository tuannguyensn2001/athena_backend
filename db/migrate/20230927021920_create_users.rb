# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :password
      t.string :email
      t.integer :email_verified_at
      t.string :role
      t.timestamps
    end
  end
end
