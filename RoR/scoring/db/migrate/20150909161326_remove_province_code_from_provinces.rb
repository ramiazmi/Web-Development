class RemoveProvinceCodeFromProvinces < ActiveRecord::Migration
  def change
    remove_column :provinces, :province_code, :string
  end
end
