require "open-uri"

users = [
  { first_name: "Phuong", last_name: "Mai", gender: "female", date_of_birth: Date.new(1998, 5, 16), is_a_trainer: true, email: "phuong@gmail.com", password: "password"},
  { first_name: "Bruno", last_name: "Vetorazo", gender: "male", date_of_birth: Date.new(1995, 1, 25), is_a_trainer: false, email: "bruno@gmail.com", password: "password"},
  { first_name: "Hannah", last_name: "Lapasaran", gender: "female", date_of_birth: Date.new(1990, 12, 15), is_a_trainer: false, email: "hannah@gmail.com", password: "password"},
  { first_name: "Taka", last_name: "Homma", gender: "male", date_of_birth: Date.new(1978, 6, 21), is_a_trainer: false, email: "taka@gmail.com", password: "password"},
  { first_name: "Justin", last_name: "Bieber", gender: "male", date_of_birth: Date.new(2000, 5, 24), is_a_trainer: false, email: "justin@gmail.com", password: "password"},
  { first_name: "Anne", last_name: "Hathaway", gender: "female", date_of_birth: Date.new(1985, 7, 1), is_a_trainer: false, email: "anne@gmail.com", password: "password"},
]

body_stats_data = [
  { weight: 68.4, body_fat: 18.2, muscle_mass: 52.1 },
  { weight: 75.3, body_fat: 21.5, muscle_mass: 55.7 },
  { weight: 59.7, body_fat: 15.9, muscle_mass: 48.2 },
  { weight: 82.6, body_fat: 24.1, muscle_mass: 58.9 },
  { weight: 64.8, body_fat: 17.6, muscle_mass: 50.3 },
  { weight: 70.9, body_fat: 19.8, muscle_mass: 53.4 }
]

avatar_urls = [
  "https://avatars.githubusercontent.com/u/198897552?v=4",
  "https://avatars.githubusercontent.com/u/47729038?v=4",
  "https://avatars.githubusercontent.com/u/186806851?v=4",
  "https://avatars.githubusercontent.com/u/84979360?v=4",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FmMbpZKhwXGXw87W450kky6z1A26.jpg&f=1&nofb=1&ipt=9895783544d9f674e5c38c007208223b155490ef87f0cb9c16ec2cb129380111",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FtLelKoPNiyJCSEtQTz1FGv4TLGc.jpg&f=1&nofb=1&ipt=fc9306f16c6843cbc51c553c5a7000fb5a7803ffcb92bc4f455298ab55517c16"
]

users.each_with_index do |user_hash, index|
  user = User.create(user_hash)
  avatar_url = avatar_urls[index]
  file = URI.parse(avatar_url).open
  user.photo.attach(io: file, filename: "#{user.first_name}.jpg", content_type: "image/jpg")
  user.save
end

users = User.all

users.each_with_index do |user, index|
  puts "Creating body stats for #{user.last_name} #{user.first_name}."
  timestamp = Random.rand(Time.zone.today.last_year..Time.zone.today)
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
