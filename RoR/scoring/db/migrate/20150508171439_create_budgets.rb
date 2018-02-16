class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :project_action
      t.string :cost_type
      t.float :cost
      t.integer :proposal_id

      t.timestamps null: false
    end
  end
end
