class WorkoutPlan < ApplicationRecord
  belongs_to :trainer, class_name: 'User'
  belongs_to :client, class_name: 'User'
  has_many :workout_sessions, dependent: :destroy

  validates :starting_date, :ending_date, presence: true
  validate :starting_date_cannot_be_in_the_past
  validate :ending_date_cannot_be_in_the_past
  validate :plan_date_cannot_be_reverse

  scope :upcoming, -> { where("starting_date >= ?", Date.today) }

  def starting_date_cannot_be_in_the_past
    if starting_date.present? && starting_date < Date.today
      errors.add(:starting_date, "can't be in the past")
    end
  end

  def ending_date_cannot_be_in_the_past
    if ending_date.present? && ending_date < Date.today
      errors.add(:ending_date, "can't be in the past")
    end
  end

  def plan_date_cannot_be_reverse
    if starting_date.present? && ending_date.present? && ending_date < starting_date
      errors.add(:ending_date, "can't be before starting date")
    end
  end

end
