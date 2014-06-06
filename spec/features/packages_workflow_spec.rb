require 'spec_helper'

describe 'Buy Packages Workflow' do
  class StubResponse
    attr_accessor :token

    def initialize(token)
      @token = token
    end
  end

  before do
    EXPRESS_GATEWAY.stub(:setup_purchase).and_return(response)
    EXPRESS_GATEWAY.stub(:redirect_url_for).and_return("http://example.com?token=#{token}")
  end

  let!(:response) { StubResponse.new(token) }
  let(:token) { "123456789" }
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
    click_on 'Rates'

    page.should have_selector('h1', text: 'OCD Packages')
    find("[data-test='#{selected_package.id}']").click
  end
end
