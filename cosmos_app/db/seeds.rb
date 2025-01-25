# Очистка существующих данных
Star.destroy_all
Planet.destroy_all
Sattelite.destroy_all

# Создание звезд
star1 = Star.create!(
  name: "Sun",
  spectral_class: "G2V",
  temperature: 5778,
  mass: 1.0,
  color: "Yellow"
)

star2 = Star.create!(
  name: "Proxima Centauri",
  spectral_class: "M5.5V",
  temperature: 3042,
  mass: 0.12,
  color: "Red"
)

# Создание планет
planet1 = Planet.create!(
  name: "Earth",
  star: star1,
  planet_type: "Terrestrial",
  mass: 1.0,
  temperature: 288
)

planet2 = Planet.create!(
  name: "Mars",
  star: star1,
  planet_type: "Terrestrial",
  mass: 0.107,
  temperature: 210
)

planet3 = Planet.create!(
  name: "Proxima Centauri b",
  star: star2,
  planet_type: "Terrestrial",
  mass: 1.27,
  temperature: 234
)

# Создание спутников
Sattelite.create!(
  name: "Moon",
  planet: planet1,
  sattelite_type: "Natural",
  mass: 0.0123,
  temperature: 220,
  form: "Spherical"
)

Sattelite.create!(
  name: "Phobos",
  planet: planet2,
  sattelite_type: "Natural",
  mass: 1.08e-8,
  temperature: 233,
  form: "Irregular"
)

Sattelite.create!(
  name: "Deimos",
  planet: planet2,
  sattelite_type: "Natural",
  mass: 2.0e-9,
  temperature: 233,
  form: "Irregular"
)

puts "Seed data created successfully!"
