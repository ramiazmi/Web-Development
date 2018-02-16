class RemoveIsAssessedFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :is_assessed, :boolean
  end
end
