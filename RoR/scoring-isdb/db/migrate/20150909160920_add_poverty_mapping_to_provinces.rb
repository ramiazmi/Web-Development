class AddPovertyMappingToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :poverty_mapping, :float
  end
end
