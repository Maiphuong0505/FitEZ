class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :workout_session
end
