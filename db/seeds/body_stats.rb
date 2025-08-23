puts "Clearing the database for body_stats..."

BodyStat.destroy_all

body_stats_data = [
  { weight: 68.4, body_fat: 18.2, muscle_mass: 52.1 },
  { weight: 75.3, body_fat: 21.5, muscle_mass: 55.7 },
  { weight: 59.7, body_fat: 15.9, muscle_mass: 48.2 },
  { weight: 82.6, body_fat: 24.1, muscle_mass: 58.9 },
  { weight: 64.8, body_fat: 17.6, muscle_mass: 50.3 },
  { weight: 70.9, body_fat: 19.8, muscle_mass: 53.4 },
  { weight: 57.8, body_fat: 14.6, muscle_mass: 40.3 },
  { weight: 72.9, body_fat: 20.8, muscle_mass: 51.4 }
]

users = User.all

users.each_with_index do |user, index|
  puts "Creating body stats for #{user.last_name} #{user.first_name}."
  timestamp = Random.rand(Time.zone.today.last_year..(Time.zone.today - 21))
  initial_stats = body_stats_data[index]
  body_stats = [
    { timestamp: timestamp, weight: initial_stats[:weight], body_fat: initial_stats[:body_fat], muscle_mass: initial_stats[:muscle_mass], user_id: user.id },
    { timestamp: timestamp + 7, weight: initial_stats[:weight] - 2, body_fat: initial_stats[:body_fat] - 3, muscle_mass: initial_stats[:muscle_mass] + 3, user_id: user.id },
    { timestamp: timestamp + 14, weight: initial_stats[:weight] - 4, body_fat: initial_stats[:body_fat] - 2, muscle_mass: initial_stats[:muscle_mass] + 2, user_id: user.id },
    { timestamp: timestamp + 21, weight: initial_stats[:weight] - 6, body_fat: initial_stats[:body_fat] - 1, muscle_mass: initial_stats[:muscle_mass] + 1, user_id: user.id }
  ]
  body_stats.each do |body_stat_hash|
    BodyStat.create(body_stat_hash)
    puts "Finished creating one body stat for #{user.last_name} #{user.first_name}."
  end
end
