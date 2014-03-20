class CreateAnswersSheets < ActiveRecord::Migration
  def change
    create_table :answers_sheets do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :subject_id
      t.integer :status      
      t.integer :result
      
      t.timestamps
    end

    add_index :answers_sheets, [:user_id, :exam_id, :subject_id]
    add_index :answers_sheets, [:user_id, :exam_id ]
    add_index :answers_sheets, [:user_id, :subject_id]
    add_index :answers_sheets, :user_id
  end
end
