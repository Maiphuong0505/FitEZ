class AddDurationToWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sessions, :duration, :integer
  end
end
