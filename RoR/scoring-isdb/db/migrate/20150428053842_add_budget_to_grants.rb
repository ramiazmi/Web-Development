class AddBudgetToGrants < ActiveRecord::Migration
  def change
  	add_column :grants, :budget, :float
  end
end
