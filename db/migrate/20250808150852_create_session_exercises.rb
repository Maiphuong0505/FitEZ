class CreateSessionExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :session_exercises do |t|
      t.references :workout_session, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.decimal :load
      t.integer :repetitions
      t.boolean :done
      t.string :difficulty

      t.timestamps
    end
  end
end
