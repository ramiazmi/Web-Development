class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :description
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
