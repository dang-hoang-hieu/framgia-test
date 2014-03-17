class CreateAnswersSheetDetails < ActiveRecord::Migration
  def change
    create_table :answers_sheet_details do |t|
      t.integer :answers_sheet_id, default: 0
      t.integer :question_id, default: 0
      t.integer :user_answer
      
      t.timestamps
    end

    add_index :answers_sheet_details, :answers_sheet_id
  end
end
