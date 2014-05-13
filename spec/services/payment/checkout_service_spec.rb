require 'spec_helper'

describe Payment::CheckoutService do
  let(:user) { create :user }
  let(:package) { create(:package) }
  let(:payment_params) { { ip_address: "192.168.1.1", express_token: '123456789' } }
  let(:service) { Payment::CheckoutService.new(package, user, payment_params) }

  it "should create a new payment" do
    expect { service.execute! }.to change(Payment, :count).by 1
  end
end
