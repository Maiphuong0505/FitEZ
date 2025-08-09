class Exercise < ApplicationRecord
  has_one_attached :photo
  has_many :session_exercises
  has_many :workout_sessions, through: :session_exercises
end
