require 'spec_helper'

describe UsersController do
  let!(:user){ create(:user) }

  describe "#info" do
    def do_request
      get :info
    end

    it 'should show user information' do
      sign_in user
      do_request
      response.should render_template :info
    end
  end
end
