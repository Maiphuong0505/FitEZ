class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :workout_session

  validates :content, presence: true, length: { maximum: 300 }
end
