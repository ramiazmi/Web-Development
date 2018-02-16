class CreateCriterionDetails < ActiveRecord::Migration
  def change
    create_table :criterion_details do |t|
      t.string :description
      t.float :weight
      t.boolean :is_active
      t.integer :criterion_id

      t.timestamps null: false
    end
  end
end
