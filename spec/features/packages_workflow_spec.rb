require 'spec_helper'

describe 'Buy Packages Workflow' do
  let!(:user) {create(:user)}
  let!(:packages) do
    create_list :package, 3, session_type: 3
    create_list :package, 3, session_type: 4
    create_list :package, 3, session_type: 5
  end
  let!(:selected_package) { packages.first }

  it 'show buy packages form' do
    visit '/'

    feature_sign_in(user)
    click_on 'Buy Packages'

    page.should have_content 'ALL PACKAGES'
    find("[data-test='#{selected_package.id}']").click

    page.should have_content 'Package bought successfully'
  end
end
