module FeatureHelper
  def feature_sign_in(user)
    click_on "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
