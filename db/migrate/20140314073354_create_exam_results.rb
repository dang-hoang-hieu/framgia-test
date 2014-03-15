class CreateExamResults < ActiveRecord::Migration
  def change
    create_table :exam_results do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :status
      t.text :result

      t.timestamps
    end

    add_index :exam_results, [:user_id, :exam_id]
  end
end
