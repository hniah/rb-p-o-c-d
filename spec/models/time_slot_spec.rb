require 'spec_helper'

describe TimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :category }
    it { should enumerize(:category).in(:booked, :blocked)}

    describe '#time_is_between_3_to_5_hours' do
      context 'Success' do

        context 'time slot is a booking' do
          let(:time_slot) { build(:time_slot) }

          it 'only accepts 3 to 5 hours duration' do
            time_slot.should be_valid
          end
        end

        context 'time slot is a blocked' do
          let(:time_slot) { build(:time_slot, :with_8_hours_slot, category: :blocked) }

          it 'will not run validation' do
            time_slot.valid?.should be_true
          end
        end
      end

      context 'Failure' do
        let(:time_slot) { build(:time_slot, :with_8_hours_slot) }

        it 'does not accept any duration outside 3 to 5 hours slot for booking slots' do
          time_slot.valid?.should be_false
        end
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
  end

  describe "#create_booking_by" do
    let(:user) { create :user }
    let(:time_slot) { build(:time_slot) }
    let(:duration) { 4 }

    context "success" do
      it "creates booking" do
        BlockedTimeSlot.should_receive(:create_blocked_time_slots!).once
        expect { time_slot.create_booking_by(user, duration) }.to change(TimeSlot, :count)
        time_slot.end_time.hour.should eq 14
        time_slot.user.should eq user
      end
    end

    context "failure" do
      before { time_slot.start_time = nil }

      it 'should not create booking' do
        BlockedTimeSlot.should_not_receive(:create_blocked_time_slots!)
        expect { time_slot.create_booking_by(user) }.to_not change(TimeSlot, :count)
      end
    end
  end
end
