class CreateExamDetails < ActiveRecord::Migration
  def change
    create_table :exam_details do |t|
      t.integer :exam_id
      t.integer :subject_id
      t.integer :level_id
      t.integer :total_questions
      t.integer :time_limit

      t.timestamps
    end

    add_index :exam_details, [:exam_id, :subject_id, :level_id]
  end
end
