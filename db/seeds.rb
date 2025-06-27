require 'faker'

puts "Limpiando base de datos..."
Schedule.delete_all
Animal.delete_all
Crop.delete_all
Employee.delete_all
Location.delete_all
User.delete_all
Activity.delete_all
AnimalGroup.delete_all

puts "Creando usuario principal..."
user = User.create!(
  email: "farmer@example.com",
  password: "password"
)

puts "Creando ubicaciones..."
location1 = Location.create!(
  name: "Granja Norte",
  surface: 50.0,
  address: Faker::Address.full_address,
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude,
  user: user
)

location2 = Location.create!(
  name: "Granja Sur",
  surface: 75.0,
  address: Faker::Address.full_address,
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude,
  user: user
)

puts "Creando actividades..."
activity_names = ["Feeding", "Milking", "Vaccination", "Cleaning", "Breeding"]
activities = activity_names.map { |name| Activity.create!(name: name) }

puts "Creando grupos de animales..."
animal_groups = [
  AnimalGroup.create!(name: "Cattle"),
  AnimalGroup.create!(name: "Caballos"),
  AnimalGroup.create!(name: "Cerdos")
]

puts "Creando empleados..."
[location1, location2].each do |loc|
  3.times do
    Employee.create!(
      email: Faker::Internet.unique.email,
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      citizen_register: Faker::IdNumber.valid,
      salary: rand(1000..2000),
      location: loc
    )
  end
end

puts "Creando cultivos..."
4.times do
  sowing = Faker::Date.between(from: 6.months.ago, to: Date.today)
  harvest = Faker::Date.between(from: sowing + 30, to: sowing + 120)
  Crop.create!(
    location: [location1, location2].sample,
    sowing_date: sowing,
    harvest_date: harvest,
    surface: rand(1.0..10.0).round(2),
    kind: ["Wheat", "Corn", "Rice", "Soy"].sample,
    follow: [true, false].sample
  )
end

puts "Creando 10 animales reales..."
10.times do
  group = animal_groups.sample
  breed = case group.name
          when "Cattle" then ["Holstein", "Angus", "Jersey"].sample
          when "Caballos" then ["Arabian", "Quarter Horse", "Thoroughbred"].sample
          when "Cerdos" then ["Duroc", "Yorkshire", "Hampshire"].sample
          end

gender_value = ["male", "female"].sample.to_s.strip.downcase
puts "Creando animal con gender: #{gender_value}"

Animal.create!(
  alias: Faker::Creature::Animal.name,
  breed: "prueba",
  birth_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
  gender: gender_value,
  follow: [true, false].sample,
  location: [location1, location2].sample,
  animal_group: group
)
end

puts "Creando programaciones (schedules)..."
10.times do
  schedulable = [Crop.all.sample, Animal.all.sample].sample
  Schedule.create!(
    schedulable: schedulable,
    activity: activities.sample,
    location: schedulable.location,
    start_date: Faker::Date.between(from: 10.days.ago, to: Date.today),
    end_date: Faker::Date.forward(days: 20)
  )
end

puts "¡Seeds completados con datos consistentes!"
