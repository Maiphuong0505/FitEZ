class AddSetToSessionExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :session_exercises, :set, :integer
  end
end
