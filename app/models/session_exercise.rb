class SessionExercise < ApplicationRecord
  belongs_to :workout_session
  has_many :exercises
end
