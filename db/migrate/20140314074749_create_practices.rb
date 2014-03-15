class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.integer :user_id
      t.integer :subject_id
      t.text :result
      t.string :status

      t.timestamps
    end

    add_index :practices, [:user_id, :subject_id]
  end
end
