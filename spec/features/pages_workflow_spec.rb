require 'spec_helper'

describe 'Static pages workflow' do

  it "should display Job Scope page" do
    visit '/'
    click_on 'Job scope and Time to task'

    page.should have_content 'JOB SCOPE AND TIME TO TASK'
    page.should have_content 'Lorem ipsum'
  end
end
