class RemovePercentageFromProvinces < ActiveRecord::Migration
  def change
    remove_column :provinces, :percentage, :integer
  end
end
