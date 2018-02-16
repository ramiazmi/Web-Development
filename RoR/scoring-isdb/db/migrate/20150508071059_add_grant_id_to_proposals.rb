class AddGrantIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :grant_id, :integer
  end
end
