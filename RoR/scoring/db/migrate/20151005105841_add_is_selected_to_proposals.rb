class AddIsSelectedToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :is_selected, :boolean
  end
end
