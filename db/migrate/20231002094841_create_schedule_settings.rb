class CreateScheduleSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_settings do |t|
      t.integer :schedule_id
      t.string :pattern

      t.timestamps
    end
  end
end
