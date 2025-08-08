class WorkoutPlan < ApplicationRecord
  belongs_to :trainer, class_name: 'User'
  belongs_to :client, class_name: 'User'
  has_many :workout_sessions, dependent: :destroy
end
