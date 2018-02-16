class AddLocalityCategoryToLocalities < ActiveRecord::Migration
  def change
    add_column :localities, :locality_category, :string, :default => 'L'
  end
end
