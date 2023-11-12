class CreateFeatureFlagObjects < ActiveRecord::Migration[7.0]
  def change
    create_table :feature_flag_objects do |t|
      t.integer :feature_flag_id
      t.integer :target_object_id

      t.timestamps
    end
  end
end
