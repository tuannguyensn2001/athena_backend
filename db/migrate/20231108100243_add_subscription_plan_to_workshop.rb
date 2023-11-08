class AddSubscriptionPlanToWorkshop < ActiveRecord::Migration[7.0]
  def up
    add_column :workshops, :subscription_plan, :string
  end

  def down
    remove_column :workshops, :subscription_plan
  end
end
