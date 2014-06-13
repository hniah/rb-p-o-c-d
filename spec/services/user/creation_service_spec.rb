require 'spec_helper'

describe User::CreationService do
  describe "#execute!" do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { User::CreationService.new(listener) }
    let(:promotion_code) { create(:promotion_code) }
    let(:user) { create(:user) }

    before { listener.stub(:add_promotion_code_successful) }

    it "should create payment" do
      expect { service.execute!(promotion_code, user) }.to change(Payment, :count).by 1
    end

    it "should change promotion_code.used" do
      service.execute!(promotion_code, user)
      promotion_code.used.should be_true
    end

    it "should redirect to user info page" do
      expect(listener).to receive(:add_promotion_code_successful).once
      service.execute!(promotion_code, user)
    end
  end
end
