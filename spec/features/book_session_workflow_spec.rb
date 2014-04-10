require 'spec_helper'

describe 'Book a session workflow' do
  it 'allows user to book a session' do
    visit '/'
    click_on 'Book a session'

    page.should have_content 'Monday'

    click_on 'Monday 9am'
    page.should have_content 'Monday booked'
  end
end
