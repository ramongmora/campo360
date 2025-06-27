puts "🧹 Cleaning database..."

Schedule.delete_all
Crop.delete_all
Animal.delete_all
Breed.delete_all
AnimalGroup.delete_all
Activity.delete_all
Employee.delete_all
Location.delete_all
User.delete_all

puts "👤 Creating user..."
user = User.create!(email: "admin@campo360.com", password: "password123")

puts "📍 Creating locations..."
location1 = Location.create!(
  name: "Estancia La Pampa",
  surface: 1200.5,
  address: "Ruta 33, Km 55, La Pampa",
  latitude: -36.6167,
  longitude: -64.2833,
  user: user
)

location2 = Location.create!(
  name: "Finca Los Álamos",
  surface: 850.0,
  address: "Camino Rural S/N, Mendoza",
  latitude: -32.8908,
  longitude: -68.8272,
  user: user
)

puts "🐄 Creating animal groups and breeds..."
cattle = AnimalGroup.create!(name: "Bovinos")
sheep = AnimalGroup.create!(name: "Ovino")

breed1 = Breed.create!(breed_type: "Aberdeen Angus", animal_group: cattle)
breed2 = Breed.create!(breed_type: "Hereford", animal_group: cattle)
breed3 = Breed.create!(breed_type: "Merino", animal_group: sheep)

puts "🐮 Creating animals..."
Animal.create!([
  { alias: "Toro Negro", birth_date: "2021-04-10", gender: "Macho", follow: true, location: location1, breed: breed1 },
  { alias: "Vaca Blanca", birth_date: "2020-09-23", gender: "Hembra", follow: false, location: location1, breed: breed2 },
  { alias: "Carnero Uno", birth_date: "2022-01-05", gender: "Hembra", follow: true, location: location2, breed: breed3 }
])

puts "🌱 Creating crops..."
Crop.create!([
  { kind: "Soja", sowing_date: "2024-10-01", harvest_date: "2025-03-15", surface: 200.0, follow: true, location: location1 },
  { kind: "Maíz", sowing_date: "2024-09-15", harvest_date: "2025-02-28", surface: 150.0, follow: false, location: location2 }
])

puts "⚙️ Creating activities..."
pasture = Activity.create!(name: "Pastoreo")
vaccination = Activity.create!(name: "Vacunación")
irrigation = Activity.create!(name: "Riego")

puts "🗓️ Creating schedules..."
Schedule.create!([
  {
    schedulable: Animal.first,
    location: location1,
    activity: pasture,
    start_date: Date.today,
    end_date: Date.today + 7
  },
  {
    schedulable: Crop.first,
    location: location1,
    activity: irrigation,
    start_date: Date.today,
    end_date: Date.today + 5
  }
])

puts "👷 Creating employees..."
Employee.create!([
  {
    email: "jose@campo360.com",
    password: "empleado123",
    first_name: "José",
    last_name: "Pérez",
    citizen_register: "20345678",
    salary: 50000,
    location: location1
  },
  {
    email: "maria@campo360.com",
    password: "empleado456",
    first_name: "María",
    last_name: "Gómez",
    citizen_register: "27345678",
    salary: 55000,
    location: location2
  }
])

puts "✅ Seeding completed successfully!"
