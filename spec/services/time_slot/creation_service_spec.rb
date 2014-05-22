require 'spec_helper'

describe TimeSlot::CreationService do
  describe "#execute!" do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:user) { create(:user, :with_payments) }
    let(:time_slot) { build_time_slot(hour: 10, min: 0) }
    let(:duration) { 3 }
    let(:service) { TimeSlot::CreationService.new(listener) }

    before { listener.stub(:create_time_slot_successful) }

    it "should send mail to admin" do
      expect(TimeSlot::CreationMailer).to receive(:send_notification_to_admin)
      service.execute!(time_slot, duration, user)
    end

    it "should send mail to user" do
      expect(TimeSlot::CreationMailer).to receive(:send_notification_to_user)
      service.execute!(time_slot, duration, user)
    end

    it "should create a time slot" do
      expect { service.execute!(time_slot, duration, user) }.to change(TimeSlot, :count).by 1
    end

    it "should redirect to booking page" do

      expect(listener).to receive(:create_time_slot_successful).once
      service.execute!(time_slot, duration, user)
    end
  end
end
