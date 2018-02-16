class CreateGrantSectors < ActiveRecord::Migration
  def change
    create_table :grant_sectors do |t|
      t.integer :percentage
      t.integer :grant_id
      t.integer :sector_id

      t.timestamps null: false
    end
  end
end
