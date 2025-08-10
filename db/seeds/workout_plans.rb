puts "Clearing the database for workout plans..."

WorkoutPlan.destroy_all

# Each workout plan will have a starting date, ending date, a trainer and a client

trainer = User.where(is_a_trainer: true)
clients = User.where(is_a_trainer: false)

# Iterate over the clients array
# For each of them we create a new instance of WorkoutPlan
gaps = [30, 60, 90]

clients.each do |client|
  puts "Creating one workout plan for #{client.last_name} #{client.first_name}."
  starting_date = client.body_stats.first.timestamp - 2
  workout_plan = WorkoutPlan.new(
    starting_date: starting_date,
    ending_date: starting_date + gaps.sample,
    trainer_id: trainer.sample.id,
    client_id: client.id
  )
  workout_plan.save
  puts "Finished creating one workout plan for #{client.last_name} #{client.first_name}."
end
