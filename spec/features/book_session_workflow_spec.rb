require 'spec_helper'

describe 'Book a session workflow' do
  let!(:user) { create(:user, :with_payments) }
  let!(:time_slot) { create(:time_slot) }
  let!(:admin) { create(:admin) }
  let!(:housekeeper) { create(:housekeeper) }

  it 'allows user to book a session' do
    visit '/'
    click_on 'Booking'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    page.should have_selector('div', text: "You are now signed in.")

    click_on "Booking"
    my_date = Time.zone.now + 1.days
    my_date = my_date.change(hour: 11, min: 00)
    find("##{my_date.strftime('%Y-%m-%d_%H-%M')}_#{housekeeper.id}").click_on "Book this slot"

    page.should have_selector('h1', text: "New Booking")

    select "4 hours", from: "Duration"
    fill_in "Remarks", with: "Ho Chi Minh City"
    click_on "Book this slot"

    page.should have_selector('div', text: "You have booked a session successfully.")

    my_date = my_date.change(hour: 14, min: 00)

    expect { find("##{my_date.strftime('%Y-%m-%d_%H-%M')}") }.to raise_error

    my_date = my_date.change(hour: 8, min: 0)
    expect { find("##{my_date.strftime('%Y-%m-%d_%H-%M')}") }.to raise_error
  end
end
