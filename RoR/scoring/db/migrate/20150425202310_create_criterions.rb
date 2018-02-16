class CreateCriterions < ActiveRecord::Migration
  def change
    create_table :criterions do |t|
      t.string :description
      t.boolean :is_active
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
