class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :equipment
      t.string :main_muscles
      t.string :starting_position
      t.string :execution

      t.timestamps
    end
  end
end
