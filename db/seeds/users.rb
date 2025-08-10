require "open-uri"

puts "Clearing the database for users..."

User.destroy_all

users = [
  { first_name: "Phuong", last_name: "Mai", gender: "female", date_of_birth: Date.new(1998, 5, 16), is_a_trainer: true, email: "phuong@gmail.com", password: "password"},
  { first_name: "Bruno", last_name: "Vetorazo", gender: "male", date_of_birth: Date.new(1995, 1, 25), is_a_trainer: false, email: "bruno@gmail.com", password: "password"},
  { first_name: "Hannah", last_name: "Lapasaran", gender: "female", date_of_birth: Date.new(1990, 12, 15), is_a_trainer: false, email: "hannah@gmail.com", password: "password"},
  { first_name: "Taka", last_name: "Homma", gender: "male", date_of_birth: Date.new(1978, 6, 21), is_a_trainer: false, email: "taka@gmail.com", password: "password"},
  { first_name: "Justin", last_name: "Bieber", gender: "male", date_of_birth: Date.new(2000, 5, 24), is_a_trainer: false, email: "justin@gmail.com", password: "password"},
  { first_name: "Anne", last_name: "Hathaway", gender: "female", date_of_birth: Date.new(1985, 7, 1), is_a_trainer: false, email: "anne@gmail.com", password: "password"},
  { first_name: "Scooter", last_name: "Suzuki", gender: "female", date_of_birth: Date.new(2000, 4, 7), is_a_trainer: true, email: "scooter@gmail.com", password: "password"},
  { first_name: "Raj", last_name: "Papa", gender: "male", date_of_birth: Date.new(1987, 3, 24), is_a_trainer: false, email: "raj@gmail.com", password: "password"},
]

avatar_urls = [
  "https://avatars.githubusercontent.com/u/198897552?v=4",
  "https://avatars.githubusercontent.com/u/47729038?v=4",
  "https://avatars.githubusercontent.com/u/186806851?v=4",
  "https://avatars.githubusercontent.com/u/84979360?v=4",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FmMbpZKhwXGXw87W450kky6z1A26.jpg&f=1&nofb=1&ipt=9895783544d9f674e5c38c007208223b155490ef87f0cb9c16ec2cb129380111",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FtLelKoPNiyJCSEtQTz1FGv4TLGc.jpg&f=1&nofb=1&ipt=fc9306f16c6843cbc51c553c5a7000fb5a7803ffcb92bc4f455298ab55517c16",
  "https://avatars.githubusercontent.com/u/46629248?v=4",
  "https://avatars.githubusercontent.com/u/100188754?v=4"
]

users.each_with_index do |user_hash, index|
  user = User.create(user_hash)
  avatar_url = avatar_urls[index]
  file = URI.parse(avatar_url).open
  user.photo.attach(io: file, filename: "#{user.first_name}.jpg", content_type: "image/jpg")
  user.save
  puts "Finished creating user #{user.last_name} #{user.first_name}."
end
