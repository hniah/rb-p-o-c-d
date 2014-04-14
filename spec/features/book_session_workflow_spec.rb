require 'spec_helper'

describe 'Book a session workflow' do
  let!(:user) { create(:user) }
  let!(:time_slot) { create(:time_slot) }

  it 'allows user to book a session' do
    visit '/'
    click_on 'Book a session'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    page.should have_content "Signed in successfully."

    click_on "Book a session"
    my_date = DateTime.now + 3.days
    my_date = my_date.change(hour: 8, minute: 00)
    find("##{my_date.strftime('%Y-%m-%d_%H-%M')}").click_on "Book this slot"

    page.should have_content "Booking created successfully"

    # page.should have_content 'Book a session'

    # click_on 'Monday 9am'
    # page.should have_content 'Monday booked'
  end
end
