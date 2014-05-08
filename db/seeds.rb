# Create admin login
Admin.destroy_all
puts "=== Admin destroyed ==="
admin = Admin.create!(email: 'admin@example.com', password: '123123', password_confirmation: '123123')
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
customer2 = User.create!(
  email: 'customer2@example.com',
  password: '123123',
  password_confirmation: '123123',
  name: 'Example Customer 2',
  address: 'Somewhere 2 in Singapore',
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
TimeSlot.delete_all
puts "=== TimeSlot destroyed ==="

sunday = Date.today.end_of_week
TimeSlot.create!(
  start_time: Time.zone.now.change(
    year: sunday.year,
    month: sunday.month,
    day: sunday.day,
    hour: 8,
    min: 0
  ),
  end_time: Time.zone.now.change(
    year: sunday.year,
    month: sunday.month,
    day: sunday.day,
    hour: 22,
    min: 0
  ),
  category: :blocked,
  housekeeper: nil,
  user: nil
)

monday = Date.today.beginning_of_week
TimeSlot.new(
  start_time: Time.zone.now.change(
    year: monday.year,
    month: monday.month,
    day: monday.day,
    hour: 8,
    min: 0
  ),
  category: :booked,
  housekeeper: nil
).create_booking_by(customer, 4)
puts "=== TimeSlot created ==="


#Create sample packages
Package.destroy_all
puts "=== Package destroyed ==="

packages = [
  {session_type: 3, hours: 0, price_cents: 0},
  {session_type: 4, hours: 4, price_cents: 11200},
  {session_type: 3, hours: 12, price_cents: 24000},
  {session_type: 5, hours: 5, price_cents: 14000},
  {session_type: 4, hours: 16, price_cents: 32000},
  {session_type: 5, hours: 20, price_cents: 40000},
  {session_type: 4, hours: 48, price_cents: 86400},
  {session_type: 3, hours: 36, price_cents: 64800},
  {session_type: 3, hours: 72, price_cents: 115200},
  {session_type: 5, hours: 60, price_cents: 108000},
  {session_type: 4, hours: 96, price_cents: 153600},
  {session_type: 5, hours: 120, price_cents: 192000}
]

packages.each { |p| package = Package.create!(p) }
puts "=== Package created ==="
