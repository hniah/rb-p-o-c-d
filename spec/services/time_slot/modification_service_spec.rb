require 'spec_helper'

describe TimeSlot::ModificationService do
  describe "#execute!" do
    let(:service) { TimeSlot::ModificationService.new(time_slot, params) }
    let(:time_slot) { create_time_slot(hour: 8, min: 0)}
    let!(:admin) { create :admin }
    let(:params) do
      {
        duration: "5",
        remarks: 'This is test',
        start_time: time_with_zone.change(hour: 11, min: 00)
      }
    end

    it "should update time slot" do
      expect(TimeSlot::ModificationMailer).to receive(:send_notification)
      expect { service.execute! }.to change(time_slot, :attributes)
      time_slot.start_time.hour.should eq 11
      time_slot.end_time.hour.should eq 16
    end
  end
end
