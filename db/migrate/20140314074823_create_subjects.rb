class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :total_questions
      t.integer :time_limit

      t.timestamps
    end
  end
end
