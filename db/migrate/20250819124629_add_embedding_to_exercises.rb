class AddEmbeddingToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :embedding, :vector, limit: 1536
  end
end
