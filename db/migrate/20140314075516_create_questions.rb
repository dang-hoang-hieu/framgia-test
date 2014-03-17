class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :subject_id
      t.integer :level_id      

      t.timestamps
    end

    add_index :questions, :subject_id
    add_index :questions, :level_id
    add_index :questions, [:subject_id, :level_id]
  end
end
