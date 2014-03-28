class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :subject_id
      t.integer :result

      t.timestamps
    end

    add_index :examinations, :user_id
    add_index :examinations, :exam_id
    add_index :examinations, :subject_id
    add_index :examinations, [:user_id, :exam_id]
  end
end
