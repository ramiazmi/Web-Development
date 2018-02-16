class AddIsSubmittedToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :is_submitted, :boolean
  end
end
