class CreateDesignReadinesses < ActiveRecord::Migration
  def change
    create_table :design_readinesses do |t|
      t.string :description
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
