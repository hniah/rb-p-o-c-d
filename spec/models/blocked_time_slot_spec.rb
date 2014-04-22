require 'spec_helper'

describe BlockedTimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time}
    it { should validate_presence_of :end_time}
    it { should validate_presence_of :category}
    it { should enumerize(:category).in(:blocked, :unblocked)}

  end

  context 'Association' do
    it { should belong_to :time_slot }
  end

  describe '#create_blocked_2_hours' do
    let!(:time_slot) { create(:time_slot, start_time: Time.zone.now.change(hour: 17, min: 00), end_time: Time.zone.now.change(hour: 21, min: 00)) }
    let(:new_blocked_time_slot) { build(:blocked_time_slot)}


    context "a before time slot" do
      it 'blocked time slot with 2 hours buffer' do
        expect { new_blocked_time_slot.create_blocked_2_hours(time_slot, 'before') }.to change(BlockedTimeSlot, :count)
        new_blocked_time_slot.start_time.hour.should eq 15
        new_blocked_time_slot.end_time.hour.should eq 17
        new_blocked_time_slot.time_slot.should eq time_slot
      end
    end

    context "a after time slot" do
      it 'blocked time slot with 2 hours buffer' do
        expect { new_blocked_time_slot.create_blocked_2_hours(time_slot,'after') }.to change(BlockedTimeSlot  , :count)
        new_blocked_time_slot.start_time.hour.should eq 21
        new_blocked_time_slot.end_time.hour.should eq 23
        new_blocked_time_slot.time_slot.should eq time_slot
      end
    end
  end

  describe ".create_blocked_time_slot!" do
    context "start at 8:00" do
      let!(:time_slot) do
        create(:time_slot,
               start_time: Time.zone.now.change(hour: 8, min: 00),
               end_time: Time.zone.now.change(hour: 12, min: 00))
      end

      it "should create 2 blocked time slots" do
        expect { BlockedTimeSlot.create_blocked_time_slots!(time_slot) }.to change(BlockedTimeSlot, :count).by(1)
      end
    end

    context "start at 12:30" do
      let!(:time_slot) do
        create(:time_slot,
               start_time: Time.zone.now.change(hour: 12, min: 30),
               end_time: Time.zone.now.change(hour: 16, min: 30))
      end

      it "should create 2 blocked time slots" do
        expect { BlockedTimeSlot.create_blocked_time_slots!(time_slot) }.to change(BlockedTimeSlot, :count).by(2)
      end
    end

    context "from 9:00 to 12:00" do
      let!(:time_slot) do
        create(:time_slot,
               start_time: Time.zone.now.change(hour: 9, min: 00),
               end_time: Time.zone.now.change(hour: 12, min: 00))
      end

      it "should create 2 blocked time slots" do
        expect { BlockedTimeSlot.create_blocked_time_slots!(time_slot) }.to change(BlockedTimeSlot, :count).by(2)
      end
    end

    context "from 13:00 to 16:00" do
      let!(:time_slot) do
        create(:time_slot,
               start_time: Time.zone.now.change(hour: 13, min: 00),
               end_time: Time.zone.now.change(hour: 16, min: 00))
      end

      it "should create 2 blocked time slots" do
        expect { BlockedTimeSlot.create_blocked_time_slots!(time_slot) }.to change(BlockedTimeSlot, :count).by(2)
      end
    end

    context "from 17:00 to 21:00" do
      let!(:time_slot) { create(:time_slot, start_time: Time.zone.now.change(hour: 17, min: 00), end_time: Time.zone.now.change(hour: 21, min: 00)) }

      it "should create 2 blocked time slots" do
        expect { BlockedTimeSlot.create_blocked_time_slots!(time_slot) }.to change(BlockedTimeSlot, :count).by(2)
      end
    end
  end
end
