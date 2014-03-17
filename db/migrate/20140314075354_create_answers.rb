class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :answer
      t.boolean :correct_answer

      t.timestamps
    end

    add_index :answers, :question_id
  end
end
