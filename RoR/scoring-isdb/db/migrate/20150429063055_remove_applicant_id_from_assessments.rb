class RemoveApplicantIdFromAssessments < ActiveRecord::Migration
  def change
    remove_column :assessments, :applicant_id, :integer
  end
end
