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

puts "Creating animal groups..."
animal_group_names = {
  "Cattle" => ["Holstein", "Jersey", "Angus", "Hereford"],
  "Horses" => ["Quarter Horse", "Arabian", "Thoroughbred", "Clydesdale"],
  "Pigs" => ["Yorkshire", "Duroc", "Berkshire", "Hampshire"],
  "Chickens" => ["Leghorn", "Rhode Island Red", "Plymouth Rock", "Silkie"],
  "Rabbits" => ["Flemish Giant", "New Zealand", "Californian", "Dutch"],
  "Goats" => ["Boer", "Nubian", "Alpine", "LaMancha"],
  "Sheep" => ["Merino", "Suffolk", "Dorset", "Hampshire"],
  "Turkeys" => ["Broad Breasted White", "Bourbon Red", "Narragansett", "Royal Palm"],
  "Ducks" => ["Pekin", "Mallard", "Khaki Campbell", "Rouen"],
  "Guinea Fowls" => ["Helmeted", "White", "Lavender", "Pearl"]
}
animal_groups = []

animal_group_names.each do |group_name, _|
  animal_groups << AnimalGroup.create!(name: group_name)
end

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
      location: location
    )
  end
end

puts "Creating crops..."
crop_types = [
  "Wheat", "Corn", "Rice", "Soy", "Barley", "Oats", "Sorghum", "Sunflower",
  "Alfalfa", "Rye", "Cotton", "Canola", "Peanuts", "Sugarcane", "Potatoes"
]

4.times do
  sowing = Faker::Date.between(from: 6.months.ago, to: Date.today)
  harvest = Faker::Date.between(from: sowing + 30, to: sowing + 180)

  Crop.create!(
    location: Location.all.sample,
    sowing_date: sowing,
    harvest_date: harvest,
    surface: rand(0.5..10.0).round(2),
    kind: crop_types.sample,
    follow: [true, false].sample
  )
end

puts "Creating 50 animals..."
50.times do
  group = animal_groups.sample
  breed_options = animal_group_names[group.name]
  Animal.create!(
    alias: Faker::Creature::Animal.name,
    breed: breed_options.sample,
    birth_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    gender: %w[Male Female].sample.capitalize,
    follow: [true, false].sample,
    location: Location.all.sample,
    animal_group: group
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
