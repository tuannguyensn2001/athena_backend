class CreateTargetGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :target_type
      t.string :description
      t.json :conditions

      t.timestamps
    end
  end
end
