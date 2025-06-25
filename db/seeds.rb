require 'faker'

puts "Cleaning database..."
Schedule.delete_all
Animal.delete_all
Crop.delete_all
Employee.delete_all
Location.delete_all
User.delete_all
Activity.delete_all
Breed.delete_all
AnimalGroup.delete_all

# Usuarios
user1 = User.create!(email: 'maria.campo@agrovida.com', password: '12345678')
user2 = User.create!(email: 'jose.mendez@cultivonatural.com', password: '12345678')

# Ubicaciones (granjas)
locations_user1 = [
  Location.create!(user: user1, name: 'Granja La Esperanza', surface: 52.3, address: 'Ruta 5 Km 103, Durazno, Uruguay', latitude: -33.3833, longitude: -56.5167),
  Location.create!(user: user1, name: 'Finca El Amanecer', surface: 34.8, address: 'Camino Los Aromos 234, Canelones, Uruguay', latitude: -34.5167, longitude: -56.2667),
  Location.create!(user: user1, name: 'Estancia Santa María', surface: 89.2, address: 'Paraje Sauce Solo, Lavalleja, Uruguay', latitude: -33.5, longitude: -54.9)
]

locations_user2 = [
  Location.create!(user: user2, name: 'Granja Los Sauces', surface: 61.5, address: 'Camino Vecinal 222, Colonia, Uruguay', latitude: -34.3, longitude: -57.4),
  Location.create!(user: user2, name: 'Chacra Monte Verde', surface: 40.1, address: 'Ruta 8 Km 49, Maldonado, Uruguay', latitude: -34.8, longitude: -55.3),
  Location.create!(user: user2, name: 'Finca Las Piedras', surface: 77.6, address: 'Camino Rural s/n, Paysandú, Uruguay', latitude: -32.3, longitude: -58.0)
]

# Grupos de animales
grupo_bovinos   = AnimalGroup.create!(name: 'Bovinos')
grupo_ovinos    = AnimalGroup.create!(name: 'Ovinos')
grupo_avicolas  = AnimalGroup.create!(name: 'Aves')
grupo_porcinoss = AnimalGroup.create!(name: 'Porcinos')  # se deja como está, pero abajo corregimos la referencia
grupo_equinos   = AnimalGroup.create!(name: 'Equinos')
puts grupo_bovinos.id
# Razas por grupo (5 por grupo)
razas_bovinos   = %w[Hereford Angus Holando Brahman Jersey].map { |r| Breed.create!(breed_type: r, animal_group_id: grupo_bovinos.id) }
razas_ovinos    = %w[Merino Corriedale Texel Romney Dorper].map { |r| Breed.create!(breed_type: r, animal_group: grupo_ovinos) }
razas_aves      = %w[Leghorn Plymouth Araucana RhodeIsland Cornish].map { |r| Breed.create!(breed_type: r, animal_group: grupo_avicolas) }
razas_porcinos  = %w[Landrace Duroc Yorkshire Pietrain Hampshire].map { |r| Breed.create!(breed_type: r, animal_group: grupo_porcinoss) }
razas_equinos   = %w[Criollo Árabe Appaloosa CuartoDeMilla Frisón].map { |r| Breed.create!(breed_type: r, animal_group: grupo_equinos) }

# Animales
def crear_animales(location, razas)
  2.times do
    razas.each do |raza|
      2.times do
        Animal.create!(
          alias: Faker::Creature::Animal.name,
          birth_date: rand(3..7).years.ago,
          gender: %w[Macho Hembra].sample,
          follow: [true, false].sample,
          location: location,
          breed: raza
        )
      end
    end
  end
end

(locations_user1 + locations_user2).each do |loc|
  crear_animales(loc, razas_bovinos)
  crear_animales(loc, razas_ovinos)
end

# Cultivos
kinds = %w[Aguacate Macadamia Maíz Marihuana Chiles Cebada]
(locations_user1 + locations_user2).each do |loc|
  10.times do
    Crop.create!(
      location: loc,
      sowing_date: Date.today - rand(30..100),
      harvest_date: Date.today + rand(60..120),
      surface: rand(1.0..10.0).round(2),
      kind: kinds.sample,
      follow: [true, false].sample
    )
  end
end

# Actividades
actividades = %w[
  Riego
  Abonado
  Poda
  Desparasitación
  Inseminación
  Cosecha
  Siembra
  Vacunación
  Alimentación
  Limpieza
].map { |a| Activity.create!(name: a) }

# Schedules
def crear_schedules_para(location)
  5.times do
    schedulable = [location.animals.sample, location.crops.sample].compact.sample
    Schedule.create!(
      schedulable: schedulable,
      location: location,
      activity: Activity.all.sample,
      start_date: Date.today + rand(1..30),
      end_date: Date.today + rand(31..60)
    )
  end
end

(locations_user1 + locations_user2).each do |loc|
  crear_schedules_para(loc)
end

puts "✅ Seeds completed successfully!"
