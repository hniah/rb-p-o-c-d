require 'spec_helper'

describe TimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :category }
    it { should enumerize(:category).in(:booked, :blocked)}

    describe '#end_time_valid?' do
      context 'Success' do
        context 'duration is between 3 - 5' do
          subject(:time_slot) { build(:time_slot) }

          it { should be_end_time_valid(3, 5) }
        end

        context 'blocked time slot' do
          subject(:time_slot) { build(:time_slot, :with_8_hours_slot, category: :blocked) }

          it { should_not be_end_time_valid(3, 5) }
        end
      end

      context 'time slot is not between 3 - 5' do
        subject(:time_slot) { build(:time_slot, :with_8_hours_slot) }

        it { should_not be_end_time_valid(3, 5) }
      end
    end

    describe '#limit_sessions_in_day' do
      context 'one session is existed' do
        before  { create_list(:time_slot, 1) }

        subject(:time_slot) { build_time_slot({hour: 17, min: 0}) }

        it { should be_valid }
      end

      context 'two sessions are existed' do
        subject(:time_slot)  { build(:time_slot) }

        before do
          create_time_slot({ hour: 8, min: 0 })
          create_time_slot({ hour: 13, min: 0})
        end

        it { should_not be_valid }
      end
    end

    describe '#restrict_booking_time' do
      context 'valid' do
        subject { build_time_slot({hour: 10, min: 0}) }

        it { should be_valid }
      end

      context 'starts at 7:00 - 10:00' do
        subject { build_time_slot(hour: 7, min: 0) }

        it { should_not be_valid }
      end

      context 'ends at 23:00' do
        subject { build_time_slot(hour: 20, min: 0) }

        it { should_not be_valid }
      end
    end

    describe '#overlap?' do
      let(:housekeeper) { create :housekeeper }
      context 'starts at 12:00' do
        let(:time_slot) {
          build(:time_slot,
                start_time: time_with_zone(hour: 10, min: 0),
                end_time: time_with_zone(hour: 13,min: 0),
                housekeeper: housekeeper
          )
        }

        before do
          create :time_slot,
                 start_time: time_with_zone(hour: 9, min: 0),
                 end_time: time_with_zone(hour: 13,min: 0),
                 housekeeper: housekeeper
        end

        it { time_slot.overlap_of?(housekeeper).should be_true }
      end

      context 'starts at 9:00' do
        let(:time_slot) {
          build(:time_slot,
                start_time: time_with_zone(hour: 9, min: 0),
                end_time: time_with_zone(hour: 12,min: 0),
                housekeeper: housekeeper
          )
        }

        before do
          create :time_slot,
                 start_time: time_with_zone(hour: 14, min: 0),
                 end_time: time_with_zone(hour: 17,min: 0),
                 housekeeper: housekeeper
        end

        it { time_slot.overlap_of?(housekeeper).should_not be_true }
      end

      context 'starts at 16:00' do
        let(:time_slot) {
          build(:time_slot,
                housekeeper: housekeeper
          )
        }

        before do
          create :time_slot,
                 start_time: time_with_zone(hour: 16, min: 0),
                 end_time: time_with_zone(hour: 19,min: 0),
                 housekeeper: housekeeper
        end

        it { time_slot.overlap_of?(housekeeper).should_not be_true }
      end
    end

    describe '#unbookable_after' do
      context 'start at 8:00 should be unbookable' do
        subject(:time_slot) do
            build(:time_slot,
                  start_time: Time.zone.now.change(hour: 8, min: 0),
                  end_time: Time.zone.now.change(hour: 11, min: 0)
            )
        end

        it { time_slot.should be_unbookable_after(2) }
      end

      context 'start at 11:00 should be unbookable' do
        subject(:time_slot) do
          build(:time_slot,
                start_time: Time.zone.now.change(hour: 10, min: 0),
                end_time: Time.zone.now.change(hour: 13, min: 0)
          )
        end

        it { should be_unbookable_after(2) }
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
    it { should have_one :feedback }
  end

  describe '.total_sessions_in_day' do
    let!(:user) { create :user, :with_payments }

    before do
      create_time_slot(hour: 8, min: 0)
      create_time_slot(hour: 13, min: 0)
    end

    subject { TimeSlot.total_sessions_in_day(date) }

    context "sessions in today" do
      let!(:date) { time_with_zone }

      it { should eq 2 }
    end

    context "sessions in tomorrow" do
      let!(:date) { time_with_zone.tomorrow }

      it { should be_zero }
    end
  end

  describe "#blocked_start_time" do
    let!(:time_slot) { build_time_slot(hour: hour, min: min) }
    let(:min) { 0 }
    subject(:blocked_start_time_hour) { time_slot.blocked_start_time.hour }

    context "starts at 10:00" do
      let(:hour) { 10 }

      it { should eq 8 }
    end

    context "start at 12:30" do
      let(:hour) { 12 }
      let(:min) { 30 }

      it { should eq 8 }
    end

    context "starts at 13: 00" do
      let(:hour) { 13 }

      it { should eq 11 }
    end

    context "starts at 16: 00" do
      let(:hour) { 16 }

      it { should eq 14 }
    end
  end

  describe "#blocked_end_time" do
    let(:min){ 0 }
    let(:time_slot) do
      build(:time_slot, end_time: time_with_zone(hour: hour, min: min))
    end

    let(:blocked_end_time_hour) { time_slot.blocked_end_time.hour }

    context "end at 13:30" do
      let(:hour) { 13 }
      let(:min) { 30 }

      context "end time hour" do
        it { blocked_end_time_hour.should eq 15 }
      end

      context "end time minute" do
        it { time_slot.blocked_end_time.min.should eq 30 }
      end
    end

    context "end at 14" do
      let(:hour) { 14 }
      it { blocked_end_time_hour.should eq 16 }
    end

    context "end at 20" do
      let(:hour) { 20 }
      it { blocked_end_time_hour.should eq 22 }
    end
  end

  describe "#session_contains?" do
    let(:time_slot) { build(:time_slot) }

    context "calendar time is in time slot" do
      let(:calendar_time) { time_with_zone(hour: 12, min: 0) }

      it { time_slot.session_contains?(calendar_time).should be_true }
    end

    context "calendar time is not in time slot" do
      let(:calendar_time) { time_with_zone(hour: 18, min: 0) }

      it { time_slot.session_contains?(calendar_time).should_not be_true }
    end
  end

  describe "#session_blocks?" do
    let(:time_slot) { build(:time_slot) }

    context "calendar time is blocked in time slot" do
      let(:calendar_time) { time_with_zone(hour: 10, min: 0) }

      it { time_slot.session_blocks?(calendar_time).should be_true }
    end

    context "calendar time is not blocked in time slot" do
      let(:calendar_time) { time_with_zone(hour: 18, min: 0) }

      it { time_slot.session_blocks?(calendar_time).should_not be_true }
    end
  end

  describe '#affordable_by?' do
    let(:time_slot) { build(:time_slot, user: user) }

    context 'time slot should be created' do
      let(:user)      { create(:user, :with_payments) }

      it { time_slot.should be_affordable_by(user, 4) }
    end

    context 'time slot should not be created' do
      let(:user) { create(:user) }

      it { time_slot.should_not be_affordable_by(user, 4) }
    end
  end

  describe '#blocked_by?' do
    context 'start at 8' do
      let(:time_slot_existed) { create_time_slot({hour: 8, min: 0}, 3) }
      let(:time_slot) { build_time_slot({hour: 8, min: 0}, 4) }

      it { time_slot.should be_blocked_by(time_slot_existed) }
    end

    context 'start at 11' do
      let(:time_slot_existed) { create_time_slot({hour: 8, min: 0}, 3) }
      let(:time_slot) { build_time_slot({hour: 11, min: 0}, 4) }

      it { time_slot.should be_blocked_by(time_slot_existed) }
    end

    context 'end at 13' do
      let(:time_slot_existed) { create_time_slot({hour: 10, min: 0}, 3) }
      let(:time_slot) { build_time_slot({hour: 8, min: 0}, 5) }

      it { time_slot.should be_blocked_by(time_slot_existed) }
    end
  end

  describe '#refundable?' do
    context 'time slot should be refunded' do
      let(:time_slot) {
                      create(:time_slot,
                         start_time: time_with_zone(hour: 10, min: 0) + 1.day,
                         end_time: time_with_zone(hour: 13, min: 0) + 1.day
                            )
                      }

      it { time_slot.should be_refundable }
    end

    context 'time slot should not be refunded' do
      let(:time_slot) {
        create(:time_slot,
               start_time: time_with_zone(hour: 10, min: 0) - 1.day,
               end_time: time_with_zone(hour: 13, min: 0) - 1.day
        )
      }

      it { time_slot.should_not be_refundable }
    end
  end
end
