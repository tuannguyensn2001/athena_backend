class ChangeNameAttributesInTargetObject < ActiveRecord::Migration[7.0]
  def up
    rename_column :target_objects, :attributes, :properties
  end

  def down
    rename_column :target_objects, :properties, :attributes
  end
end
