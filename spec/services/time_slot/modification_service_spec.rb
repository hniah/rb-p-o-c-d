require 'spec_helper'

describe TimeSlot::ModificationService do
  describe "#execute!" do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { TimeSlot::ModificationService.new(listener) }
    let(:time_slot) { create_time_slot(hour: 8, min: 0)}
    let!(:admin) { create :admin }
    let(:housekeeper) { create(:housekeeper) }
    let(:params) do
      {
        duration: "5",
        remarks: 'This is test',
        start_time: time_with_zone(hour: 11, min: 00),
        housekeeper: housekeeper
      }
    end

    before { listener.stub(:update_time_slot_successful)}

    it "should update time slot" do
      expect { service.execute!(time_slot, params) }.to change(time_slot, :attributes)
      time_slot.start_time.hour.should eq 11
      time_slot.end_time.hour.should eq 16
      time_slot.housekeeper.should eq housekeeper
    end

    it "should send an email to admin" do
      expect(TimeSlot::ModificationMailer).to receive(:send_notification)
      service.execute!(time_slot, params)
    end

    it "should redirect to user info page" do
      expect(listener).to receive(:update_time_slot_successful).once
      service.execute!(time_slot, params)
    end
  end
end
