require 'spec_helper'

describe 'User Workflow' do
  let!(:user){create(:user)}

  it "should show user information" do
    visit '/'
    click_on 'Sign in'

    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    page.should have_content "Signed in successfully."
    click_on "My Account"

    page.should have_content "User Account"
  end
end
