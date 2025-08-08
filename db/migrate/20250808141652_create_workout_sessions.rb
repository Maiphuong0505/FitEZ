class CreateWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_sessions do |t|
      t.references :workout_plan, null: false, foreign_key: true
      t.string :session_name
      t.date :date_and_time
      t.boolean :with_trainer

      t.timestamps
    end
  end
end
