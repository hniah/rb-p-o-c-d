require 'spec_helper'

describe PackagesController do

  let(:user) {create(:user)}

  before {
    create(:package_12_hours)
    create(:package_16_hours)
  }

  describe "#buy_package" do
    def do_request
      get :buy_package
    end

    it 'should display buy form' do
      sign_in user
      do_request
      response.should render_template :buy_package
    end
  end

  describe "#do_buy_package" do
    let(:package) { create(:package_12_hours) }

    def do_request
      patch :do_buy_package, user: { package_id: package.id }
    end

    it 'create a package for user' do
      sign_in user
      expect { do_request }.to change(user.packages, :count).by(1)

      response.should redirect_to bookings_path
      flash[:notice].should eq 'Package bought successfully'
    end

  end
end
