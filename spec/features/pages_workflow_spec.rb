require 'spec_helper'

describe 'Static pages workflow' do

  before { create :page}

  it "should display FAQ page" do
    visit '/'
    click_on 'FAQ'

    page.should have_content 'FAQ'
  end
end
