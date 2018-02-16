class AddKillingFactorToCriterionDetails < ActiveRecord::Migration
  def change
    add_column :criterion_details, :killing_factor, :boolean, :default => false
  end
end
