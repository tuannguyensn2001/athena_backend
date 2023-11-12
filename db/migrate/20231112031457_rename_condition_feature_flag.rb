class RenameConditionFeatureFlag < ActiveRecord::Migration[7.0]
  def up
    rename_column :feature_flags, :condition, :conditions
  end

  def down
    rename_column :feature_flags, :conditions, :condition
  end
end
