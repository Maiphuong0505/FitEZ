module ExercisesHelper
  include Rails.application.routes.url_helpers

  def exercise_photo_url(exercise)
    exercise.photo.attached? ? rails_blob_url(exercise.photo, only_path: false) : nil
  end
end
