class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.integer :percentage
      t.integer :fund_source_id
      t.integer :proposal_id

      t.timestamps null: false
    end
  end
end
