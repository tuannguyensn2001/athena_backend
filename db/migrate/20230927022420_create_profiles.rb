class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :username
      t.string :school
      t.integer :birthday
      t.string :avatar_url

      t.timestamps
    end
  end
end
