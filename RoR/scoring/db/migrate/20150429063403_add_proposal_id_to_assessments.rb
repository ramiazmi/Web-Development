class AddProposalIdToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :proposal_id, :integer
  end
end
