require 'spec_helper'

describe BookingsHelper do
  describe '#display_booked_slot_info' do
    let!(:time_slots) { build_list(:time_slot, 1) }
    let!(:housekeeper) { create(:housekeeper) }

    it 'displays a button for user to book if the time slot is available' do
      time = Time.zone.now.change(hour: 16, minute: 0)
      helper.display_booked_slot_info(time_slots, time_with_zone, time,housekeeper.id).should have_css ".available"
    end
  end

  describe "#find_booked_time_slot" do
    let(:booked_time_slots) { build_list(:time_slot, 3) }

    context "calendar time slot is available" do
      let(:calendar_time_slot) { time_with_zone(hour: 16, min: 00) }

      it "should not find booked time slot" do
        helper.time_slot_used(booked_time_slots, calendar_time_slot).should be_nil
      end
    end

    context "calendar time slot is booked" do
      let(:calendar_time_slot) { time_with_zone(hour: 10, min: 00) }

      it "should find booked time slot" do
        helper.time_slot_used(booked_time_slots, calendar_time_slot).should_not be_nil
      end
    end
  end

  describe '#total_sessions' do
    let(:calendar_time) { time_with_zone(hour: 10, min: 0) }

    before do
      create_time_slot(hour: 10, min: 0)
      create_time_slot(hour: 16, min: 0)
      create(:time_slot, start_time: time_with_zone + 2.days, end_time: time_with_zone + 2.days )
    end

    it 'should be equal 2' do
      helper.total_sessions(TimeSlot.all, calendar_time).should eq 2
    end
  end
end
