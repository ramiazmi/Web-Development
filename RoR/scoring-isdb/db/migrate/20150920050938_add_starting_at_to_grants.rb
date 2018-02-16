class AddStartingAtToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :starting_at, :date
  end
end
