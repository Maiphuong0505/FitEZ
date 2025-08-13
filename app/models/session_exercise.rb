class SessionExercise < ApplicationRecord
  belongs_to :workout_session
  belongs_to :exercise

  validates :repetitions, presence: true, numericality: {
    only_integer: true,
    greater_than: 0,
    message: "must be more than 0"
  }
  validates :load, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :set, presence: true, numericality: {
    only_integer: true,
    greater_than: 0,
    message: "must be more than 0"
  }
end
