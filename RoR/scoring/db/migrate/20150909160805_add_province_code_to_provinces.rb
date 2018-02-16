class AddProvinceCodeToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :province_code, :string
  end
end
