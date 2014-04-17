require 'spec_helper'

describe 'Buy Packages Workflow' do
  let!(:user) {create(:user)}
  let!(:selected_package) { create(:package_12_hours) }

  before { create(:package_16_hours) }

  it 'show buy packages form' do
    visit '/'

    feature_sign_in(user)
    click_on 'Buy Packages'

    page.should have_content 'ALL PACKAGES'
    select selected_package.id, from: 'Select your package'
    click_on 'Buy'

    page.should have_content 'Package bought successfully'
  end
end
