class BodyStat < ApplicationRecord
  belongs_to :user

  validates :timestamp, presence: true
  validate :timestamp_cannot_be_in_the_future
  validates :weight, presence: true, numericality: {
    greater_than: 0,
    message: "must be more than 0"
  }
  validates :body_fat, presence: true, numericality: {
    greater_than: 0,
    message: "must be more than 0"
  }
  validates :muscle_mass, presence: true, numericality: {
    greater_than: 0,
    message: "must be more than 0"
  }

  def timestamp_cannot_be_in_the_future
    if timestamp.present? && timestamp > Date.today
      errors.add(:timestamp, "can't be in the future")
    end
  end

end
