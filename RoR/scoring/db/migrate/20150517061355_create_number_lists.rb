class CreateNumberLists < ActiveRecord::Migration
  def change
    create_table :number_lists do |t|
      t.string :number_label

      t.timestamps null: false
    end
  end
end
