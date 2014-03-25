class CreateExamsUsers < ActiveRecord::Migration
  def change
    create_table :exams_users do |t|
      t.integer :user_id
      t.integer :exam_id

      t.timestamps
    end

    add_index :exams_users, :user_id
    add_index :exams_users, :exam_id
    add_index :exams_users, [:user_id, :exam_id]
  end
end
