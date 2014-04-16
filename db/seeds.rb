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


#Create sample packages
Package.destroy_all
puts "=== Package destroyed ==="

packages = [
  {name: '1 x 4-hour session', hours: 4, price_cents: 112},
  {name: '1 x 5-hour session', hours: 5, price_cents: 140},
  {name: '4 x 3-hour sessions', hours: 12, price_cents: 240},
  {name: '4 x 4-hour sessions', hours: 16, price_cents: 320},
  {name: '4 x 5-hour sessions', hours: 20, price_cents: 400},
  {name: '12 x 3-hour sessions', hours: 36, price_cents: 648},
  {name: '12 x 4-hour sessions', hours: 48, price_cents: 864},
  {name: '12 x 5-hour sessions', hours: 60, price_cents: 1080},
  {name: '24 x 3-hour sessions', hours: 72, price_cents: 1152},
  {name: '24 x 4-hour sessions', hours: 96, price_cents: 1536},
  {name: '24 x 5-hour sessions', hours: 120, price_cents: 1920}
]

packages.each { |p| package = Package.create!(p) }
