class WorkoutSession < ApplicationRecord
  belongs_to :workout_plan
  has_many :session_exercises, dependent: :destroy
  has_many :exercises, through: :session_exercises
  has_many :comments, dependent: :destroy
end
