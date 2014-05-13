require 'spec_helper'

describe PackagesController do
  let(:user) {create(:user)}

  describe "#buy_package" do
    def do_request
      get :buy_package
    end

    before {
      create(:package_12_hours)
      create(:package_16_hours)
    }

    it 'should display buy form' do
      sign_in user
      do_request
      assigns(:packages).should_not be_nil
      assigns(:sessions_type_list).should_not be_nil
      response.should render_template :buy_package
    end
  end
end
