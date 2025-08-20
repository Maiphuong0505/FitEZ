class WorkoutSession < ApplicationRecord
  belongs_to :workout_plan
  has_many :session_exercises, dependent: :destroy
  has_many :exercises, through: :session_exercises
  has_many :comments, dependent: :destroy

  validates :session_name, presence: true
  validates :date_time, presence: true
  validates :with_trainer, inclusion: { in: [true, false] }
  validates :duration, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 30,
    message: "must be at least 30 minutes"
  }
  validate :date_time_cannot_be_in_the_past
  validate :date_time_cannot_be_outside_of_plan_date
  # validate :date_time_unique

  scope :upcoming, -> { where("date_time >= ?", Time.current) }

  def date_time_cannot_be_in_the_past
    if date_time.present? && date_time < Time.current
      errors.add(:date_time, "can't be in the past")
    end
  end

  def date_time_cannot_be_outside_of_plan_date
    session_date = date_time.to_date
    plan_range = workout_plan.starting_date..workout_plan.ending_date

    if date_time.present? && !plan_range.cover?(session_date)
      errors.add(:date_time, "must be within plan period")
    end
  end

  def date_time_unique
    if current_user.trainer?
      existing_sessions = current_user.workout_plans_as_trainer.map(&:workout_sessions).flatten!
    else
      existing_sessions = current_user.workout_plans_as_client.map(&:workout_sessions).flatten!
    end
    existing_sessions_date_time = existing_sessions.map(&:date_time)
    if date_time.present? && existing_sessions_date_time.include(date_time)
      errors.add(:date_time, "already exists. Please choose another date and time")
    end
  end
end
