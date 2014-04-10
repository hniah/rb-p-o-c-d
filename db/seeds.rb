# Create admin login
Admin.destroy_all
Admin.create!(email: 'admin@example.com', password: '123123', password_confirmation: '123123')

# Create locations
north = Location.find_or_create_by!(name: 'North')
east = Location.find_or_create_by!(name: 'East')
Location.find_or_create_by!(name: 'West')
Location.find_or_create_by!(name: 'Central')
Location.find_or_create_by!(name: 'North-East')

# Create sample housekeeper
Housekeeper.destroy_all
housekeeper = Housekeeper.create!(
  name: 'Example Housekeeper',
  gender: 'female',
  email: 'example_housekeeper@example.com',
  contact: '12345678',
  address: 'Somewhere in Singapore',
  postal: '652342',
  date_of_birth: 20.years.ago
)
housekeeper.locations << [north, east]

# Create sample time slots
TimeSlot.destroy_all
sunday = Date.today.end_of_week
time_slot = TimeSlot.create!(
  start_time: DateTime.new(sunday.year, sunday.month, sunday.day, 8, 00),
  end_time:   DateTime.new(sunday.year, sunday.month, sunday.day, 22, 00),
  category: :blocked
)
