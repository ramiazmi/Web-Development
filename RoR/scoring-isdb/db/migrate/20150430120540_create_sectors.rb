class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :programme
      t.integer :percentage
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
