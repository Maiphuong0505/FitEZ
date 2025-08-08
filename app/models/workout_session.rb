class WorkoutSession < ApplicationRecord
  belongs_to :workout_plan
  has_many :exercises, dependent: :destroy
end
