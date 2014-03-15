class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :exam
      t.integer :total_questions
      t.integer :time_limit

      t.timestamps
    end
  end
end
