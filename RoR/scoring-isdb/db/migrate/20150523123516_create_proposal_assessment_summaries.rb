class CreateProposalAssessmentSummaries < ActiveRecord::Migration
  def change
    create_table :proposal_assessment_summaries do |t|
      t.boolean :is_assessed
      t.float :total_mark
      t.integer :proposal_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
