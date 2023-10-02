class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.string :channel
      t.timestamp :start
      t.integer :minutes
      t.string :status
      t.timestamp :end
      t.integer :workshop_id
      t.integer :created_by
      t.timestamp :deleted_at
      t.boolean :approve_update_status_automatically
      t.integer :parent_id, default: 0

      t.timestamps
    end
  end
end
