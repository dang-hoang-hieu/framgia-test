class CreateAnswersSheets < ActiveRecord::Migration
  def change
    create_table :answers_sheets do |t|
      t.integer :examination_id
      t.integer :subject_id
      t.integer :status      
      t.integer :result
      
      t.timestamps
    end

    add_index :answers_sheets, [:examination_id, :subject_id]
    add_index :answers_sheets, [:examination_id ]
    add_index :answers_sheets, [:subject_id]
  end
end
