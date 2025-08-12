class SessionExercise < ApplicationRecord
  belongs_to :workout_session
  belongs_to :exercise

  validates :exercise_id, presence: true
  validates :repetitions, presence: true
  validates :load, presence: true
  validates :set, presence: true
end
