require 'spec_helper'

describe PaymentsController do
  describe '#express_checkout' do
    class StubResponse
      attr_accessor :token

      def initialize(token)
        @token = token
      end
    end

    let!(:response) { StubResponse.new(token) }
    let(:token) { "123456789" }
    let(:remote_ip) { "192.168.1.100" }
    let(:user) {create(:user)}
    let(:package) { create(:package_12_hours) }
    let(:payment) { build(:payment) }

    def do_request
      patch :express_checkout, user: { package_id: package.id }
    end

    before do
      EXPRESS_GATEWAY.stub(:setup_purchase).and_return(response)
      EXPRESS_GATEWAY.stub(:redirect_url_for).and_return("http://example.com?token=#{token}")
    end

    it "should redirect to paypal" do
      sign_in user
      do_request
      expect {payment.create_payment!(user, package, token, remote_ip) }.to change(Payment, :count).by(1)
      response.should redirect_to EXPRESS_GATEWAY.redirect_url_for(token)
    end
  end

  describe '#success_payment' do
    let(:user) { create(:user) }
    let!(:pending_payment) { create(:payment, :with_pending_status) }

    before { sign_in user }
    before { do_request }

    def do_request
      get :success_payment, token: '123456789', PayerID: '2222'
    end

    it 'payment should be updated' do
      flash[:notice].should eq "Package bought successfully!"
      response.should redirect_to bookings_path
    end
  end

  describe '#cancel_payment' do
    let(:user) { create(:user) }
    let!(:pending_payment) { create(:payment, :with_pending_status) }

    before { sign_in user }
    before { do_request }

    def do_request
      get :cancel_payment, token: '123456789'
    end

    it 'payment should be destroyed' do
      flash[:alert].should eq "Transaction destroyed!"
      response.should redirect_to buy_package_path
    end
  end
end
