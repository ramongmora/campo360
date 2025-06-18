require 'faker'

puts "Cleaning database..."
Schedule.delete_all
Animal.delete_all
Crop.delete_all
Employee.delete_all
Location.delete_all
User.delete_all
Activity.delete_all
AnimalGroup.delete_all

puts "Creating user..."
user = User.create!(
  email: "farmer@example.com",
  password: "password"
)

puts "Creating 2 locations..."
2.times do
  Location.create!(
    name: Faker::Address.community,
    address: Faker::Address.full_address,
    user: user
  )
end

puts "Creating 10 activities..."
activity_names = [
  "Vaccination", "Feeding", "Cleaning", "Milking", "Shearing",
  "Breeding", "Hoof Trimming", "Health Check", "Weighing", "Grazing"
]
activities = activity_names.map { |name| Activity.create!(name: name) }

puts "Creating 10 animal groups..."
animal_group_names = [
  "Cattle", "Horses", "Pigs", "Chickens", "Rabbits",
  "Goats", "Sheep", "Turkeys", "Ducks", "Guinea Fowls"
]
animal_groups = animal_group_names.map { |name| AnimalGroup.create!(name: name) }

puts "Creating 5 employees per location..."
Location.all.each do |location|
  5.times do
  Employee.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    citizen_register: Faker::IdNumber.valid,
    salary: rand(1000..2000),
    location_id: location.id # 👈 cambio aquí
)
  end
end

puts "Creating 4 crops..."
4.times do
  sowing = Faker::Date.between(from: 6.months.ago, to: Date.today)
  harvest = Faker::Date.between(from: sowing + 30, to: sowing + 180)

  Crop.create!(
    location: Location.all.sample,
    sowing_date: sowing,
    harvest_date: harvest,
    surface: rand(0.5..10.0).round(2),
    kind: %w[Wheat Corn Rice Soy].sample,
    follow: [true, false].sample
  )
end

puts "Creating 50 animals..."
50.times do
  Animal.create!(
    alias: Faker::Creature::Animal.name,
    breed: Faker::Creature::Animal.name,
    birth_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    gender: %w[male female].sample,
    follow: [true, false].sample,
    location: Location.all.sample,
    animal_group: animal_groups.sample
  )
end


puts "Creating 50 schedules (randomly assigned to crops or animals)..."
50.times do
  schedulable = (rand < 0.5 ? Crop.all.sample : Animal.all.sample)
  Schedule.create!(
    schedulable: schedulable,
    activity: activities.sample,
    location: schedulable.location,
    start_date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    end_date: Faker::Date.forward(days: 30)
  )
end

puts "✅ Seeds completed successfully!"
