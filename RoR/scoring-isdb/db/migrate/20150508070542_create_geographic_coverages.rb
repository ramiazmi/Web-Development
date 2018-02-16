class CreateGeographicCoverages < ActiveRecord::Migration
  def change
    create_table :geographic_coverages do |t|
      t.integer :beneficiaries_number
      t.integer :proposal_id
      t.integer :locality_id

      t.timestamps null: false
    end
  end
end
