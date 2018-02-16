class AddIsAssessedToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :is_assessed, :boolean
  end
end
