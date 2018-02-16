class CreateDevelopmentGoals < ActiveRecord::Migration
  def change
    create_table :development_goals do |t|
      t.string :description
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
