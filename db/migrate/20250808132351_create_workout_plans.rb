class CreateWorkoutPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_plans do |t|
      t.date :starting_date
      t.date :ending_date
      t.references :trainer, null: false, foreign_key: { to_table: :users }
      t.references :client, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
