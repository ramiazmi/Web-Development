class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.float :mark
      t.integer :grant_id
      t.integer :applicant_id
      t.integer :category_id
      t.integer :criterion_id

      t.timestamps null: false
    end
  end
end
