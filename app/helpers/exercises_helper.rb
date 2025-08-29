module ExercisesHelper
  include Rails.application.routes.url_helpers

  def exercise_photo_url(exercise)
    exercise.photo.attached? ? rails_blob_url(exercise.photo, only_path: false) : nil
  end
end

=begin
How to add preview photo in form with cloudinary

Created a Helper Method:
I made a helper (exercise_photo_url) that returns the full image URL for each exercise’s attached photo using rails_blob_url because for some reason the .photo.key not always match

Passed URLs to the View:
In the ERB partial, I built a hash mapping exercise IDs to their photo URLs and added it as a JSON data attribute (data-exercise-photos) on a <div>.

Rendered an Image Preview Area:
I added an <cl_image_tag> tag (id="exercise-preview") to the form, which starts hidden and empty.

Updated the Stimulus Controller:

On page load, I parsed the JSON data attribute to get the mapping of exercise IDs to photo URLs.
Had to set up Tom Select for the dropdown.
Added a listener for changes to the dropdown.
Showed the Preview on Selection:
When the user selects an exercise, the JS:

Gets the selected exercise’s ID.
Looks up the corresponding photo URL.
Sets the <cl_image_tag> tag’s src to that URL and makes it visible.
=end
