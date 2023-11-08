class CreateTargetObjects < ActiveRecord::Migration[7.0]
  def change
    create_table :target_objects do |t|
      t.string :type
      t.string :status
      t.integer :target_id
      t.json :tags
      t.json :attributes

      t.timestamps
    end
  end
end
