# Create admin login
Admin.destroy_all
puts "=== Admin destroyed ==="
admin = Admin.create!(email: 'admin@ourcleaningdepartment.com', password: '123123', password_confirmation: '123123')
puts "=== Admin created ==="

#Create sample packages
Package.destroy_all
puts "=== Package destroyed ==="

packages = [
  {name: '3x0 hours', session_type: 3, hours: 0, price_cents: 0},
  {name: '4x1 hours',session_type: 4, hours: 4, price_cents: 11200},
  {name: '3x4 hours',session_type: 3, hours: 12, price_cents: 24000},
  {name: '5x1 hours',session_type: 5, hours: 5, price_cents: 14000},
  {name: '4x4 hours',session_type: 4, hours: 16, price_cents: 32000},
  {name: '5x4 hours',session_type: 5, hours: 20, price_cents: 40000},
  {name: '4x12 hours',session_type: 4, hours: 48, price_cents: 86400},
  {name: '3x12 hours',session_type: 3, hours: 36, price_cents: 64800},
  {name: '3x24 hours',session_type: 3, hours: 72, price_cents: 115200},
  {name: '5x12 hours',session_type: 5, hours: 60, price_cents: 108000},
  {name: '4x24 hours',session_type: 4, hours: 96, price_cents: 153600},
  {name: '5x24 hours',session_type: 5, hours: 120, price_cents: 192000}
]

packages.each { |p| package = Package.create!(p) }
puts "=== Package created ==="

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
  contact_number: '6652-3568',
  alternative_contact_number: '6652-3578',
  block: "unblock"
)
customer2 = User.create!(
  email: 'customer2@example.com',
  password: '123123',
  password_confirmation: '123123',
  name: 'Example Customer 2',
  address: 'Somewhere 2 in Singapore',
  postal: '651289',
  contact_number: '6652-3568',
  alternative_contact_number: '6652-3578',
  block: "unblock"
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

housekeeper2 = Housekeeper.create!(
  name: 'Example Housekeeper 2',
  gender: 'female',
  contact: '12345678910',
  address: 'Somewhere in Singapore 2',
  postal: '652342',
  date_of_birth: 21.years.ago,
  experience_level: '1 year',
  language_spoken: 'English',
  special_remarks: 'She is nice'
)
housekeeper2.locations << [north]
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
  housekeeper: housekeeper,
  user: nil
)

monday = Date.today.beginning_of_week + 1.week

puts "=== TimeSlot created ==="

# Create sample page categories
PageCategory.delete_all
puts "=== Page destroyed ==="
blog_category = PageCategory.create!(
  title: "Blogs",
  description: "This is page category description",
  page_category_alias: "blogs"
)

puts "=== Page created ==="

# Create sample pages
Page.delete_all
puts "=== Page destroyed ==="
Page.create!(
  title: "JOB SCOPE and TIME-TO-TASK",
  article_alias: "job_scope_and_time_to_task",
  intro_text: "",
  intro_image: "",
  description: '<p><img alt="" src="/uploads/ckeditor/pictures/25/content_Duties_and_guide.jpg" style="height:800px; width:756px" /></p>

<p><strong><u>Packages</u></strong></p>

<table align="left" border="2" cellpadding="0" cellspacing="0" style="width:632px">
	<tbody>
		<tr>
			<td style="width:140px">
			<p style="text-align:center">&nbsp;</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center"><strong>Ad-hoc</strong></p>

			<p style="text-align:center">($28/hr)</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center"><strong>4 sessions</strong></p>

			<p style="text-align:center">($20/hr)</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center"><strong>12 sessions </strong></p>

			<p style="text-align:center">($18/hr)</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center"><strong>24 sessions</strong></p>

			<p style="text-align:center">($16/hr)</p>
			</td>
		</tr>
		<tr>
			<td style="width:140px">
			<p style="text-align:center"><strong>3-hour session</strong></p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">-</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$240</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$648</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$1152</p>
			</td>
		</tr>
		<tr>
			<td style="width:140px">
			<p style="text-align:center"><strong>4-hour session</strong></p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$112</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$320</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$864</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$1536</p>
			</td>
		</tr>
		<tr>
			<td style="width:140px">
			<p style="text-align:center"><strong>5-hour session</strong></p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$140</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$400</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$1080</p>
			</td>
			<td style="width:123px">
			<p style="text-align:center">$1920</p>
			</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>All sessions to be utilized within a year</p>

<p><u>Additional charges</u></p>

<p>Extended hour: $28/hr</p>

<p>Weekend charges: $10/session</p>

<p>&nbsp;</p>
',
  short_description: "This is JOB SCOPE and TIME-TO-TASK",
)

Page.create!(
  title: 'Frequently Asked Questions',
  article_alias: 'faq',
  intro_text: '',
  intro_image: '',
  description: '<p><span style="font-size:14px"><span style="font-family:arial,helvetica,sans-serif">Here is a list of questions that we were frequently asked. Do feel free to contact us for any clarifications!</span></span></p>

<p><u><strong><span style="font-size:18px">General</span></strong></u></p>

<p><span style="font-size:18px">1. Who are your housekeepers?</span></p>

<blockquote>
<p>OCD housekeepers are Singaporean/PR with experiences in the area of housekeeping.</p>
</blockquote>

<p><span style="font-size:18px">2. What is the difference between hiring a part-time and a full-time domestic helper?</span></p>

<blockquote>
<p>A full-time domestic helper stays in with you. Thus, unlike having a full-time domestic helper, there is no need to provide accommodation and meals for a part-time housekeeper. A part-time housekeeper only goes to your place at the scheduled timing that you have chosen.</p>
</blockquote>

<p><span style="font-size:18px">3. How do I decide whether to hire a full-time or part-time helper?</span></p>

<blockquote>
<p>It really depends on your needs. Consider these questions:</p>

<ol>
	<li>&nbsp;Do you need someone to be at home 24/7 to help attend to young infants/children or the elderly? Or</li>
	<li>Do you need someone to take care of your household chores, to free up your time for other aspects of your life?</li>
</ol>

<p>If your priority is having someone to be around to help take care of the young or the old, hiring a full-time helper may better suit your need.</p>

<p>However, if what you really need is maintaining a clean home, then having a part-time housekeeping service would suffice.</p>
</blockquote>

<p><span style="font-size:18px">4. Does OCD provide full-time domestic helper services?</span></p>

<blockquote>
<p>No.</p>

<p>OCD only provides part-time housekeeping services. We urge you to think through your priorities and needs first before engaging any services (be it full-time or part-time services).</p>
</blockquote>

<p><span style="font-size:18px">5. What are the advantages of hiring an OCD part-time housekeeper?</span></p>

<blockquote>
<p>There are many advantages of hiring our housekeepers, and below are the top 5:</p>

<ol>
	<li><strong>Greater privacy</strong> If you are one who values your personal space, having a part-time housekeeper ensures minimal invasion of your privacy. Our part-time housekeepers do not live in your house, and only goes over to your place to provide the housekeeping service at the scheduled timing.</li>
	<li><strong>More time</strong> Instead of spending your time on mundane household chores, having a part-time housekeeper frees up your time for the more important things in life.</li>
	<li><strong>Professional and tailored cleaning services </strong>Our housekeepers undergo professional training modules approved by WDA to ensure delivery of quality services. In addition, you are encouraged to provide feedback on our housekeepers&rsquo; performances, or to communicate to our housekeepers to help tailor their cleaning services to best suit your household/needs.</li>
	<li>&nbsp;<strong>Flexibility </strong>We aim to provide the greatest flexibility by offering packages which will allow you to book cleaning sessions according to your scheduleWe are also not sticky about following the duties stated. Tell us what your priorities are and our housekeepers will adapt their cleaning routine accordingly.</li>
	<li><strong>Satisfaction</strong> We guarantee satisfaction with our services. We will attend to any feedback/request/enquiry promptly. Do not hesitate to contact us if you have any queries.&nbsp;</li>
</ol>
</blockquote>

<p><span style="font-size:18px">6. Will the same housekeeper be working for me?</span></p>

<blockquote>
<p>This is completely up to you. You could book a cleaning session from the housekeeper you are familiar with or any other housekeepers that is working in your area.</p>

<p>We do however encourage choosing the same housekeeper as this will allow our housekeepers to be familiar with your cleaning needs. However, if the housekeeper whose service you have booked had to take sick leave, we would contact you (asap) to check if you would prefer to cancel the appointment or to accept a replacement (if available).</p>
</blockquote>

<p><span style="font-size:18px">7. Do I have to be at home during the cleaning session?</span></p>

<blockquote>
<p>Not necessarily.</p>

<p>We would recommend that you (or someone else) be present during the first few sessions. You could help orientate our housekeeper and to communicate any expectations or special requests. Once you are comfortable with your housekeeper, you can come up with some kind of key arrangement with her.</p>
</blockquote>

<p>&nbsp;</p>

<p><u><strong><span style="font-size:18px">OCD Packages</span></strong></u><br />
&nbsp;</p>

<p><span style="font-size:18px">8. Is there a validity period for the packages?</span></p>

<blockquote>
<p>Yes.</p>

<p>Each package is valid for 12 months from the date it is purchased.</p>
</blockquote>

<p><span style="font-size:18px">9. I have purchased a 4-session package. Can I top up the price difference and convert to a 12-/24-session package?</span></p>

<blockquote>
<p>Unfortunately, we do not accept conversion of packages. We are glad that you are happy with our services and hope that you can get to enjoy the full cost-saving benefits of the 12-/24-session package for your next purchase.</p>
</blockquote>

<p><span style="font-size:18px">10. Why don&rsquo;t you offer routine (once a week/twice a week) packages like the other companies?</span></p>

<blockquote>
<p>We understand the hectic schedule of most of our clients. Therefore, we would like to offer the flexibility to choosing any day and any timing that is convenient for you.</p>

<p>However, if you prefer something more routine, simply let us know and book your subsequent sessions in advance to save you the trouble of booking every week (i.e., block booking of the Wednesday 8am-12pm slot, for the month of June).</p>
</blockquote>

<p><span style="font-size:18px">11. Can I change my bookings?</span></p>

<blockquote>
<p>Yes.</p>

<p>However, we will finalize all bookings (for the next day) at 6pm. In other words, any last minute cancellations after 6pm will still be considered as one session. This is to ensure a smooth work flow for our housekeepers and to minimise any disruptions to their work schedules. We seek your understanding in adhering to this requirement.</p>
</blockquote>
',
  short_description: '',
)

Page.create!(
  title: 'TERMS AND CONDITION',
  article_alias: 'terms_and_condition',
  intro_text: '',
  intro_image: '',
  description: '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>
',
  short_description: '',
)

Page.create!(
  title: 'Disclaimer and Privacy Policy',
  article_alias: 'disclaimer_privacy_policy',
  intro_text: '',
  intro_image: '',
  description: '<p><img alt="" src="/uploads/ckeditor/pictures/21/content_1796537_748220688530559_581789471_n.jpg" style="height:160px; width:160px" /></p>

<p>Disclaimer:</p>

<p>The information in this web site offers only an overview of our services. Information is subject to change and should not be used as an absolute guide. Users should contact Our Cleaning Department LLP (OCD) for a consultation. OCD accepts no responsibility for any losses or mishaps direct or indirect that may occur from the use of this website and the information contained within it.<br />
OCD accepts no liability or responsibility, for any loss or damage to any property whatsoever real or personal to whomsoever or any loss or expense related to such loss or damage to the Client or Housekeeper or any person whomever. In no event shall OCD be liable for indirect, incidental, consequential, punitive or special damages to the Client or Housekeeper or any person whomsoever even if OCD has been advised of the possibility of such damages.</p>
',
  short_description: '',
)

Page.create!(
  title: 'About Us',
  article_alias: 'about_us',
  intro_text: '',
  intro_image: '',
  description: '<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>

<p>&nbsp;</p>

<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>

<p>&nbsp;</p>

<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>
',
  short_description: '',
)

Page.create!(
  title: 'Join Us',
  article_alias: 'join_us',
  intro_text: '',
  intro_image: '',
  description: '<p><img alt="" src="/uploads/ckeditor/pictures/2/content_51c7ebf6_294fe783_51c7b682_621d6fb5_anh-troll-comment-facebook.jpg" style="float:left; height:321px; margin-left:10px; margin-right:10px; width:301px" />Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc enim lorem, sodales in urna eget, facilisis ultrices urna. Aliquam varius mollis neque ut facilisis. Nunc orci arcu, dapibus quis felis vel, luctus posuere mi. Aliquam ultrices consectetur neque, in ullamcorper est porta id. Nullam ornare vitae quam sit amet hendrerit. Vestibulum in ante varius, faucibus erat a, suscipit urna. Integer euismod ultricies gravida. Donec commodo et tellus et pellentesque. Duis laoreet malesuada hendrerit. Integer ac ipsum risus.</p>
',
  short_description: '',
)

Page.create!(
  title: 'news 1',
  article_alias: 'news_1',
  intro_text: 'this is test 1',
  intro_image: 'http://localhost:3000/uploads/ckeditor/pictures/4/1656006_764366283582666_9128065351197862810_n.jpg',
  description: '<p>Lorem Ipsum&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
',
  short_description: 'This is short description...',
  page_category_id: blog_category.id
)

Page.create!(
  title: 'news 2',
  article_alias: 'news_2',
  intro_text: 'this is test 2',
  intro_image: 'http://localhost:3000/uploads/ckeditor/pictures/4/1656006_764366283582666_9128065351197862810_n.jpg',
  description: '<p>Lorem Ipsum&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
',
  short_description: 'This is short description...',
  page_category_id: blog_category.id
)

Page.create!(
  title: 'this is test',
  article_alias: 'this_is_test',
  intro_text: 'this is test 3',
  intro_image: 'http://localhost:3000/uploads/ckeditor/pictures/4/1656006_764366283582666_9128065351197862810_n.jpg',
  description: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
',
  short_description: 'This is short description...',
  page_category_id: blog_category.id
)
puts "=== Page created ==="
