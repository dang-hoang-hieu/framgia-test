class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :level_id
      t.string :result
      t.string :status

      t.timestamps
    end

    add_index :practices, [:user_id, :subject_id, :level_id]
  end
end
