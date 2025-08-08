# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
require "nokogiri"

puts "Clearing the database..."

Exercise.destroy_all

# muscles = %w[chest, back, shoulders, biceps, triceps, abdominals, legs, calves]

# muscles.each do |muscle|
#   url = ""
# end

url = "https://www.simplyfitness.com/pages/workout-exercise-guides"

html_file = URI.parse(url).read
html_doc = Nokogiri::HTML.parse(html_file)
