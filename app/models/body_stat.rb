class BodyStat < ApplicationRecord
  belongs_to :user

  validates :timestamp, presence: true
  validate :timestamp_cannot_be_in_the_future
  validates :weight, presence: true
  validates :body_fat, presence: true
  validates :muscle_mass, presence: true

  def timestamp_cannot_be_in_the_future
    if timestamp.present? && timestamp > Date.today
      errors.add(:timestamp, "can't be in the future")
    end
  end

end
