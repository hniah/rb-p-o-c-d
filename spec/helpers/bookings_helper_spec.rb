require 'spec_helper'

describe BookingsHelper do
  describe '#display_booked_slot_info' do
    let!(:time_slots) { build_list(:time_slot, 1) }
    let!(:blocked_time_slots) { build_list(:blocked_time_slot, 1) }

    it 'displays a button for user to book if the time slot is available' do
      time = Time.zone.now.change(hour: 16, minute: 0)
      helper.display_booked_slot_info(time_slots,blocked_time_slots, Time.zone.now, time).should have_css ".available"
    end
  end

  describe "#find_booked_time_slot" do
    let(:booked_time_slots) { build_list(:time_slot, 3) }

    context "calendar time slot is available" do
      let(:calendar_time_slot) { Time.zone.now.change(hour: 16, min: 00) }

      it "should not find booked time slot" do
        helper.time_slot_used(booked_time_slots, calendar_time_slot).should be_nil
      end
    end

    context "calendar time slot is booked" do
      let(:calendar_time_slot) { Time.zone.now.change(hour: 10, min: 00) }

      it "should find booked time slot" do
        helper.time_slot_used(booked_time_slots, calendar_time_slot).should_not be_nil
      end
    end
  end

  describe "#find_blocked_time_slot" do
    let(:blocked_time_slots) { build_list(:blocked_time_slot, 2) }

    context 'calendar time slot is available' do
      let(:calendar_time_slot) { Time.zone.now.change(hour: 16, min: 0) }

      it 'should not find blocked time slot' do
        helper.time_slot_used(blocked_time_slots, calendar_time_slot).should be_nil
      end
    end

    context 'calendar time slot is not available' do
      let(:calendar_time_slot) { Time.zone.now.change(hour: 15, min: 0) }

      it 'should find blocked time slot' do
        helper.time_slot_used(blocked_time_slots, calendar_time_slot).should be_present
      end
    end
  end
end
