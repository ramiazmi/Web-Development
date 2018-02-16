class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :locality_code
      t.string :locality_name
      t.float :population
      t.integer :province_id

      t.timestamps null: false
    end
  end
end
