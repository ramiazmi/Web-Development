class CreateFundSources < ActiveRecord::Migration
  def change
    create_table :fund_sources do |t|
      t.string :description
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
