class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :answers_sheet_detail_id
      t.integer :answer_id
      t.integer :checked

      t.timestamps
    end
  end
end
