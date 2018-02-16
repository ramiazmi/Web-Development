class AddAverageMarkToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :average_mark, :float
  end
end
