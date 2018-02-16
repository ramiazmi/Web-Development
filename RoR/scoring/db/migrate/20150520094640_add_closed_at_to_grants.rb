class AddClosedAtToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :closed_at, :date
  end
end
