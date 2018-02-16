class AddClassificationToGeographicCoverages < ActiveRecord::Migration
  def change
    add_column :geographic_coverages, :classification, :string
  end
end
