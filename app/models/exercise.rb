class Exercise < ApplicationRecord
  has_one_attached :photo
  has_many :session_exercises
  has_many :workout_sessions, through: :session_exercises

  has_neighbors :embedding
  after_create :set_embedding
  after_update :set_embedding

  private

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Exercise: #{name}. Equipment: #{equipment}. Main muscles: #{main_muscles}. Starting position: #{starting_position}. Execution: #{execution}."
      }
    )
    embedding = response['data'][0]['embedding']
    update_column(:embedding, embedding)
  end
end
