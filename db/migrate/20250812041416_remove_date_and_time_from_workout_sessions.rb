class RemoveDateAndTimeFromWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    remove_column :workout_sessions, :date_and_time, :date
  end
end
