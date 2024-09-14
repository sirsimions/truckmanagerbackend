# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Truck.create([
  # { truck: 'Truck 1', customer: 'Customer A', product: 'Product X', depot: 'Depot 1', route_name: 'Mombasa - Kampala', date_loaded: '2024-08-01', mode: 'Flatbed', loaded_status: 'Loaded', location: 'Nairobi', status_date: '2024-08-01', status_time: '14:00', status: 'Loaded', remarks: 'On time', distance_covered: 500, region: 'East', country: 'Kenya' },
  # { truck: 'Truck 2', customer: 'Customer B', product: 'Product Y', depot: 'Depot 2', route_name: 'Mombasa - Jinja', date_loaded: '2024-08-02', mode: 'Tanker', loaded_status: 'Empty', location: 'Mombasa', status_date: '2024-08-02', status_time: '16:00', status: 'Empty', remarks: 'Delayed', distance_covered: 200, region: 'Coast', country: 'Kenya' }
# ])


# db/seeds.rb

Author.create([
  { name: 'suhara logistics', department: 'transport', password: ENV['DEFAULT_PASSWORD'] },
  { name: 'suhara', department: 'admin1', password: ENV['DEFAULT_PASSWORD'], email: 'okola.s168@gmail.com' },
  { name: 'suhara logistics', department: 'transport', password: ENV['DEFAULT_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Shadab', department: 'transport', password: ENV['SHADAB_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Nityanand', department: 'transport', password: ENV['NITYANAND_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Kuntal', department: 'transport', password: ENV['KUNTAL_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Angila', department: 'transport', password: ENV['ANGILA_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Julia', department: 'transport', password: ENV['JULIA_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Wilson', department: 'transport', password: ENV['WILSON_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Obadiah', department: 'transport', password: ENV['OBADIAH_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Faith M', department: 'transport', password: ENV['FAITHM_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Bonface', department: 'transport', password: ENV['BONFACE_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Sunil', department: 'transport', password: ENV['SUNIL_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Leo', department: 'transport', password: ENV['LEO_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Saifali', department: 'transport', password: ENV['SAIFALI_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Gatabazi', department: 'transport', password: ENV['GATABAZI_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Rodney', department: 'transport', password: ENV['RODNEY_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Bidget', department: 'transport', password: ENV['BIDGET_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Veronica', department: 'transport', password: ENV['VERONICA_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Simion', department: 'transport', password: ENV['SIMION_PASSWORD'], email: 'jane@gmail.com' },
  { name: 'Arafat', department: 'transport', password: ENV['ARAFAT_PASSWORD'], email: 'jane@gmail.com' }
])
