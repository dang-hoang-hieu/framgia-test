class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :answers_sheet_detail_id
      t.integer :user_answer

      t.timestamps
    end
  end
end
