class CreateCustomAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_attributes do |t|
      t.string :name
      t.string :target_type
      t.string :data_type
      t.string :description
      t.boolean :visible

      t.timestamps
    end
  end
end
