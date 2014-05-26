require 'spec_helper'

describe UsersHelper do
  describe "#refund??" do
    context "should modify" do
      let(:time_slot) { create(:time_slot,
                                start_time: time_with_zone(hour: 10, min: 0) + 2.day,
                                end_time: time_with_zone(hour: 13, min: 0) + 2.day
      )}

      it { helper.refund?(time_slot.start_time).should be_true }
    end

    context "should not modify" do
      let(:time_slot) { create(:time_slot,
                               start_time: time_with_zone(hour: 10, min: 0) - 3.day,
                               end_time: time_with_zone(hour: 13, min: 0) - 3.day
      )}

      it { helper.refund?(time_slot.start_time).should_not be_true }
    end
  end

  describe "#check_show_delete???" do
    context "should show delete button" do
      let(:time_slot) { create(:time_slot,
                               start_time: time_with_zone(hour: 10, min: 0),
                               end_time: time_with_zone(hour: 13, min: 0)
      )}

      it { helper.check_show_delete?(time_slot.start_time).should be_true }
    end

    context "should not show delete button" do
      let(:time_slot) { create(:time_slot,
                               start_time: time_with_zone(hour: 10, min: 0) - 2.day,
                               end_time: time_with_zone(hour: 13, min: 0) - 2.day
      )}

      it { helper.check_show_delete?(time_slot.start_time).should_not be_true }
    end
  end
end
