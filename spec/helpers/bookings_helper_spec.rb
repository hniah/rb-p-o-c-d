require 'spec_helper'

describe BookingsHelper do
  describe '#display_booked_slot_info' do
    let(:time_slots) { build_list(:time_slot, 1) }

    it 'display a message if the time slot is booked' do
      time = DateTime.now.change(hour: 8, minute: 00)
      helper.display_booked_slot_info(time_slots, Date.today, time).should == time_slots.first.housekeeper.name
    end

    it 'does not display anything if the time slot is empty' do
      time = DateTime.now.change(hour: 16, minute: 0)
      helper.display_booked_slot_info(time_slots, Date.today, time).should == ''
    end
  end
end
