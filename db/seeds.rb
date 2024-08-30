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

Author.create([
  { name: 'suhara logistics', department: 'transport', password: 'suhara123'},
  { name: 'suhara', department: 'admin1', password: 'suhara123#' }
])

