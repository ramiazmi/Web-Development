class RemovePopulationFromProvinces < ActiveRecord::Migration
  def change
    remove_column :provinces, :population, :float
  end
end
