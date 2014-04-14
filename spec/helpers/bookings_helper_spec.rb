require 'spec_helper'

describe BookingsHelper do
  describe '#display_booked_slot_info' do
    let!(:time_slots) { build_list(:time_slot, 1) }

    it 'display a message if the time slot is booked' do
      time = DateTime.now.change(hour: 8, minute: 00)
      helper.display_booked_slot_info(time_slots, Date.today, time).should have_css '.booked'
    end

    it 'displays a button for user to book if the time slot is available' do
      time = DateTime.now.change(hour: 16, minute: 0)
      helper.display_booked_slot_info(time_slots, Date.today, time).should have_css ".available"
    end
  end
end
