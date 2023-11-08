class RenameTypeInTargetObject < ActiveRecord::Migration[7.0]
  def up
    rename_column :target_objects, :type, :target_type
  end

  def down
    rename_column :target_objects, :target_type, :type
  end
end
