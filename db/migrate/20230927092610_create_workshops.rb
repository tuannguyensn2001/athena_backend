class CreateWorkshops < ActiveRecord::Migration[7.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :thumbnail
      t.string :private_code
      t.string :code
      t.boolean :approve_student
      t.boolean :prevent_student_leave
      t.boolean :approve_show_score
      t.boolean :disable_newsfeed
      t.boolean :limit_policy_teacher
      t.boolean :is_show
      t.string :subject
      t.string :grade
      t.boolean :is_lock

      t.timestamps
    end
  end
end
