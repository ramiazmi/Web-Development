class AddIsSelectionDoneToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :is_selection_done, :boolean
  end
end
