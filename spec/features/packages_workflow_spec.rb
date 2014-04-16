require 'spec_helper'

describe 'Buy Packages Workflow' do
  let!(:user) {create(:user)}

  before do
    create(:package_12_hours)
    create(:package_16_hours)
  end

  it 'show buy packages form' do
    visit '/'

    feature_sign_in(user)
    click_on 'Buy Packages'

    page.should have_content 'ALL PACKAGES'
    select '4 x 3-hour sessions', from: 'Select your package'
    click_on 'Buy'

    page.should have_content 'Package bought successfully'
  end
end
