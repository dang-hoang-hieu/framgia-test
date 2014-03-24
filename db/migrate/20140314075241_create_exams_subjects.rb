class CreateExamsSubjects < ActiveRecord::Migration
  def change
    create_table :exams_subjects do |t|      
      t.integer :subject_id
      t.integer :exam_id
      t.integer :total_questions
      t.integer :time_limit
      t.timestamps
    end
    add_index :exams_subjects, [:exam_id]
    add_index :exams_subjects, [:subject_id]
    add_index :exams_subjects, [:exam_id, :subject_id]
  end
end
