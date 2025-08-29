class AddScheduledTrainerSessionToWorkoutPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_plans, :scheduled_trainer_session, :integer
  end
end
