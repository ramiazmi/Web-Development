class CreateAssessmentCriterionDetails < ActiveRecord::Migration
  def change
    create_table :assessment_criterion_details do |t|
      t.float :mark
      t.integer :criterion_detail_id
      t.integer :assessment_id

      t.timestamps null: false
    end
  end
end
