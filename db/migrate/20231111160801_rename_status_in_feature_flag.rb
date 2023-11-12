class RenameStatusInFeatureFlag < ActiveRecord::Migration[7.0]
  def up
    rename_column :feature_flags, :status, :state
  end

  def down
    rename_column :feature_flags, :state, :status
  end
end
