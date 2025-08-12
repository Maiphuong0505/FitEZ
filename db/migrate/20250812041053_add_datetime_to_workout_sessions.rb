class AddDatetimeToWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sessions, :date_time, :datetime
  end
end
