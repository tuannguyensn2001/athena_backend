class CreateFeatureFlags < ActiveRecord::Migration[7.0]
  def change
    create_table :feature_flags do |t|
      t.string :code
      t.string :description
      t.string :status
      t.string :target_type
      t.json :condition

      t.timestamps
    end
  end
end
