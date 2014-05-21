require 'spec_helper'

describe UsersHelper do
  describe "#modify?" do
    context "should modify" do
      let(:time_slot) { create(:time_slot,
                                start_time: time_with_zone(hour: 10, min: 0) + 2.day,
                                end_time: time_with_zone(hour: 13, min: 0) + 2.day
      )}

      it { helper.modify?(time_slot.start_time).should be_true }
    end

    context "should not modify" do
      let(:time_slot) { create(:time_slot,
                               start_time: time_with_zone(hour: 10, min: 0) - 3.day,
                               end_time: time_with_zone(hour: 13, min: 0) - 3.day
      )}

      it { helper.modify?(time_slot.start_time).should_not be_true }
    end
  end
end
