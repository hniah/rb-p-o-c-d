require 'spec_helper'

describe BookingsHelper do
  describe '#display_booked_slot_info' do
    let!(:time_slots) { build_list(:time_slot, 1) }

    it 'displays a button for user to book if the time slot is available' do
      time = DateTime.now.change(hour: 16, minute: 0)
      helper.display_booked_slot_info(time_slots, Date.today, time).should have_css ".available"
    end
  end

  describe "#find_booked_time_slot" do
    let(:booked_time_slots) { build_list(:time_slot, 3) }

    context "calendar time slot is available" do
      let(:calendar_time_slot) { Time.now.change(hour: 14, min: 00) }

      it "should not find booked time slot" do
        helper.find_booked_time_slot(booked_time_slots, calendar_time_slot).should be_nil
      end
    end

    context "calendar time slot is booked" do
      let(:calendar_time_slot) { Time.now.change(hour: 10, min: 00) }

      it "should find booked time slot" do
        helper.find_booked_time_slot(booked_time_slots, calendar_time_slot).should_not be_nil
      end
    end
  end
end
