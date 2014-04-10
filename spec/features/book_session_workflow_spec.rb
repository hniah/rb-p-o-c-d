require 'spec_helper'

describe 'Book a session workflow' do
  let!(:time_slot) { create(:time_slot) }

  it 'allows user to book a session' do
    pending 'TODO'

    visit '/'
    click_on 'Book a session'

    page.should have_content 'Book a session'
    # page.should have_content 'Book a session'

    click_on 'Monday 9am'
    page.should have_content 'Monday booked'
  end
end
