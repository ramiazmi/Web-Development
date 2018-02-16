class RemoveGrantIdFromAssessments < ActiveRecord::Migration
  def change
    remove_column :assessments, :grant_id, :integer
  end
end
