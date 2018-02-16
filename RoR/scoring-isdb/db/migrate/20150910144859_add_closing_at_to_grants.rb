class AddClosingAtToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :closing_at, :date
  end
end
