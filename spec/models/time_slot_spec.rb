require 'spec_helper'

describe TimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :category }
    it { should enumerize(:category).in(:booked, :blocked)}

    # describe "#time_slots_are_2_hours_apart" do
    #   context "start time is invalid" do
    #     let(:time_slot) { build(:time_slot, start_time: Time.zone.now.change(hour: 8, min: 00)) }
    #
    #     before do
    #       create(:time_slot, start_time: Time.zone.now.change(hour: 11, min: 00), end_time: Time.zone.now.change(hour: 14, min: 00))
    #     end
    #
    #     it "should not allow time slot to be created" do
    #       time_slot.should_not be_valid
    #     end
    #   end
    #
    #   context "end time is invalid" do
    #     let(:time_slot) { build(:time_slot, start_time: Time.zone.now.change(hour: 12, min: 00), end_time: Time.zone.now.change(hour: 15, min: 00)) }
    #
    #     before do
    #       create(:time_slot, start_time: Time.zone.now.change(hour: 13, min: 00), end_time: Time.zone.now.change(hour: 16, min: 00))
    #     end
    #
    #     it "should not allow time slot to be created" do
    #       time_slot.should_not be_valid
    #     end
    #   end
    # end

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
