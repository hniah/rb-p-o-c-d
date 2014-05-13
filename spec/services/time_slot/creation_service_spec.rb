require 'spec_helper'

describe TimeSlot::CreationService do
  describe "#execute" do
    let(:user) { create(:user, :with_packages) }
    let(:params) { attributes_for(:time_slot, duration: 3, start_time: time_with_zone(hour: 10, min: 0) ) }
    let(:service) { TimeSlot::CreationService.new(params, user) }

    it "should send mail to admin" do
      expect(TimeSlot::CreationMailer).to receive(:send_notification)
      service.execute!
    end

    it "should create a time slot" do
      expect { service.execute! }.to change(TimeSlot, :count).by 1
    end
  end
end
