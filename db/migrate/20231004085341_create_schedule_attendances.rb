class CreateScheduleAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_attendances do |t|
      t.integer :user_id
      t.integer :schedule_id

      t.timestamps
    end
  end
end
