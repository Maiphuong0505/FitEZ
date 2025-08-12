require 'time'
puts "Clearing the database of workout sessions..."

WorkoutSession.destroy_all

muscles = %w[Upper-body Lower-body Full-body Push Pull Legs]

workout_plans = WorkoutPlan.all

workout_plans.each do |plan|
  WorkoutSession.create(
    workout_plan_id: plan.id,
    session_name: "#{muscles.sample} Focus",
    date_time: Time.parse("#{plan.starting_date + 2} #{rand(10..22)}:00:00"),
    with_trainer: true
  )

  puts "Finished creating one session for #{plan.client.first_name}'s workout plan."
end
