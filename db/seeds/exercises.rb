require "open-uri"
require "nokogiri"

puts "Clearing the database..."

Exercise.destroy_all

url = "https://www.simplyfitness.com/pages/workout-exercise-guides"

html_file = URI.parse(url).read
html_doc = Nokogiri::HTML.parse(html_file)

ul_lists = html_doc.search(".exo-ol")
exercise_paths = ul_lists.map do |list|
  list.children.children.map { |li| li.attribute_nodes.first.value }
end

exercise_urls = exercise_paths.flatten.map do |exercise_path|
  "https://www.simplyfitness.com#{exercise_path}"
end

exercise_urls.each do |exercise_url|
  exercise_file = URI.parse(exercise_url).read
  exercise_doc = Nokogiri::HTML.parse(exercise_file)

  p_items = exercise_doc.search("p").children.map { |p| p.text.strip }

  span_items = exercise_doc.search(".exo-info div span").children.map { |item| item.text.strip }

  name = exercise_doc.search("h1").text.strip
  equipment = span_items[0]
  main_muscles = span_items[1]
  starting_position = p_items[1]
  execution = p_items[2]

  img_url = exercise_doc.search("img")[11].attribute_nodes.first.value

  file = URI.parse(img_url).open
  exercise = Exercise.new(
    name: name,
    equipment: equipment,
    main_muscles: main_muscles,
    starting_position: starting_position,
    execution: execution
  )
  exercise.photo.attach(io: file, filename: "#{name}.jpg", content_type: "image/png")
  exercise.save
end

puts "Finish creating #{Exercise.count} exercises!"
