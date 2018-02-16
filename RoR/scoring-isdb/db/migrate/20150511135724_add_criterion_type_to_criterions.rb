class AddCriterionTypeToCriterions < ActiveRecord::Migration
  def change
    add_column :criterions, :criterion_type, :string
  end
end
