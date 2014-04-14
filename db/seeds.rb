# Create admin login
Admin.destroy_all
puts "=== Admin destroyed ==="
Admin.create!(email: 'admin@example.com', password: '123123', password_confirmation: '123123')
puts "=== Admin created ==="

# Create locations
north = Location.find_or_create_by!(name: 'North')
east = Location.find_or_create_by!(name: 'East')
Location.find_or_create_by!(name: 'West')
Location.find_or_create_by!(name: 'Central')
Location.find_or_create_by!(name: 'North-East')
puts "=== Location created ==="

# Create sample customer
User.destroy_all
puts "=== User destroyed ==="
customer = User.create!(
  email: 'customer@example.com',
  password: '123123',
  password_confirmation: '123123',
  name: 'Example Customer',
  address: 'Somewhere in Singapore',
  postal: '651289',
  contact_number: '6652-3568'
)
puts "=== User created ==="

# Create sample housekeeper
Housekeeper.destroy_all
puts "=== Housekeeper destroyed ==="
housekeeper = Housekeeper.create!(
  name: 'Example Housekeeper',
  gender: 'female',
  contact: '12345678',
  address: 'Somewhere in Singapore',
  postal: '652342',
  date_of_birth: 20.years.ago,
  experience_level: '1 year',
  language_spoken: 'English',
  special_remarks: 'She is nice'
)
housekeeper.locations << [north, east]
puts "=== Housekeeper created ==="

# Create sample time slots
TimeSlot.destroy_all
puts "=== TimeSlot destroyed ==="

sunday = Date.today.end_of_week
time_slot = TimeSlot.create!(
  start_time: Time.local(sunday.year, sunday.month, sunday.day, 8, 00),
  end_time:   Time.local(sunday.year, sunday.month, sunday.day, 22, 00),
  category: :blocked,
  housekeeper: housekeeper,
  user: nil
)

monday = Date.today.beginning_of_week
time_slot = TimeSlot.create!(
  start_time: Time.local(monday.year, monday.month, monday.day, 8, 00),
  end_time:   Time.local(monday.year, monday.month, monday.day, 12, 00),
  category: :booked,
  housekeeper: housekeeper,
  user: customer
)
puts "=== TimeSlot created ==="
