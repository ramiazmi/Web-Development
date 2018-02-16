class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :project_name
      t.integer :sector_id
      t.text :project_background
      t.date :proposal_date
      t.date :expected_start_date
      t.float :project_period
      t.text :project_aim
      t.text :target_audience
      t.integer :development_goal_id
      t.text :project_actions_description
      t.text :stakeholders_choosing_method
      t.text :stakeholders_description
      t.text :project_approach
      t.text :technical_methodology
      t.text :logical_framework
      t.text :supervision
      t.text :project_sustainability
      t.string :executive_organization
      t.text :joint_ventures
      t.text :organization_experience
      t.string :contact_person
      t.string :contact_phone
      t.string :contact_email
      t.text :positive_impact
      t.text :negative_impact
      t.integer :short_term_work_opportunities
      t.integer :long_term_work_opportunities
      t.text :project_schedule
      t.text :photos_before_implementation
      t.string :project_schedule
      t.text :project_photos
      t.integer :design_readiness_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
