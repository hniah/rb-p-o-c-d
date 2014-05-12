require 'spec_helper'

describe TimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :category }
    it { should enumerize(:category).in(:booked, :blocked)}

    describe '#time_slot_is_between' do
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
            time_slot.should be_valid
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

    describe '#limit_sessions_in_day' do
      context 'success' do
        let!(:time_slots)  { create_list(:time_slot, 1) }
        let!(:time_slot) { build_time_slot({hour: 17, min: 0}) }

        it 'should be allowed to create time slot' do
          time_slot.save.should == true
        end
      end

      context 'failure' do
        let!(:time_slot)  { build(:time_slot) }

        before do
          create_time_slot({ hour: 8, min: 0 })
          create_time_slot({ hour: 13, min: 0})
        end

        it 'should not be allowed to create time slot' do
          time_slot.save.should == false
        end
      end
    end

    describe '#restrict_booking_time' do
      context 'valid' do
        let(:time_slot) { build_time_slot({hour: 10, min: 0}) }

        it { time_slot.should be_valid }
      end

      context 'starts at 7:00 - 10:00' do
        let(:time_slot) { build_time_slot(hour: 7, min: 0) }

        it { time_slot.should_not be_valid }
      end

      context 'ends at 23:00' do
        let(:time_slot) { build_time_slot(hour: 20, min: 0) }

        it { time_slot.should_not be_valid }
      end
    end

    describe '#creatable?' do
      context 'starts at 12:00' do
        let(:time_slot) { build_time_slot({ hour: 12, min: 0 }, 3) }

        before { create_time_slot({ hour: 9, min: 0 }, 3) }

        it { time_slot.should_not be_valid }
      end

      context 'starts at 9:00' do
        let(:time_slot) { build_time_slot(hour: 9, min: 0) }

        before { create_time_slot(hour: 14, min: 0) }

        it { time_slot.should be_valid }
      end

      context 'starts at 16:00' do
        let(:time_slot) { build_time_slot(hour: 16, min: 0) }

        before { create(:time_slot) }

        it { time_slot.should be_valid }
      end
    end

    describe '#unbookable_after_hours' do
      context 'start at 8:00' do
        let(:time_slot) do
            build(:time_slot,
                  start_time: Time.zone.now.change(hour: 8, min: 0),
                  end_time: Time.zone.now.change(hour: 11, min: 0)
            )
        end

        it { time_slot.should_not be_valid }
      end

      context 'start at 11:00' do
        let(:time_slot) do
          build(:time_slot,
                start_time: Time.zone.now.change(hour: 10, min: 0),
                end_time: Time.zone.now.change(hour: 13, min: 0)
          )
        end

        it { time_slot.should_not be_valid }
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
  end

  describe '.total_sessions_in_day' do
    let!(:user) { create :user, :with_packages }
    before do
      create_time_slot(hour: 8, min: 0)
      create_time_slot(hour: 13, min: 0)
    end

    it 'should return total sessions in day' do
      TimeSlot.total_sessions_in_day(time_with_zone).should == 2
      TimeSlot.total_sessions_in_day(time_with_zone.tomorrow).should == 0
    end
  end

  describe "#create_booking_by" do
    let(:user) { create :user, :with_packages }
    let(:time_slot) { build_time_slot( hour: 10, min: 0 )}
    let(:duration) { 4 }
    let!(:admin) { create :admin }

    context "success" do
      it "creates booking" do
        expect { time_slot.create_booking_by(user, duration) }.to change(TimeSlot, :count)
        time_slot.end_time.hour.should eq 14
        time_slot.user.should eq user
        expect { AdminMailer.notification_email('new').deliver }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "failure" do
      let(:time_slot) { build_time_slot(hour: 20, min: 0) }

      it 'should not create booking' do
        expect { time_slot.create_booking_by(user, 5) }.to raise_error
      end
    end
  end

  describe "#updated" do
    let(:user) { create :user }
    let(:time_slot) { create(:time_slot)}
    let!(:admin) { create :admin }
    let(:params) { {duration: "3",
                    remarks: 'This is test',
                    start_time: Time.zone.now.tomorrow.change(hour: 11, min: 00)
    } }

    context "success" do
      it "start_time should be updated" do
        expect { time_slot.updated(params) }.to change(time_slot, :start_time)
        time_slot.start_time.hour.should eq 11
      end

      it 'end_time should not be updated' do
        expect { time_slot.updated(params) }.not_to change(time_slot, :end_time)
        time_slot.end_time.hour.should eq 14
      end

      let(:params_with_duration_5) { {duration: "5",
                                      remarks: 'This is test',
                                      start_time: Time.zone.now.tomorrow.change(hour: 11, min: 00)
      }}
      it 'end_time should be updated' do
        expect { time_slot.updated(params_with_duration_5) }.to change(time_slot, :end_time)
        time_slot.end_time.hour.should eq 16
      end

      it 'remarks should be updated' do
        expect { time_slot.updated(params) }.to change(time_slot, :remarks).to('This is test')
      end

      it "should be send mail for admin" do
        expect { AdminMailer.notification_email('updated').deliver }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  describe "#blocked_start_time" do
    let!(:time_slot) { build_time_slot(hour: hour, min: min) }
    let(:min) { 0 }
    let(:blocked_start_time_hour) { time_slot.blocked_start_time.hour }

    context "starts at 10:00" do
      let(:hour) { 10 }

      it "returns the correct blocked start time" do
        blocked_start_time_hour.should eq 8
      end
    end

    context "start at 12:30" do
      let(:hour) { 12 }
      let(:min) { 30 }

      it "returns the correct blocked start time" do
        blocked_start_time_hour.should eq 8
      end
    end

    context "starts at 13: 00" do
      let(:hour) { 13 }

      it "returns the correct blocked start time" do
        blocked_start_time_hour.should eq 11
      end
    end

    context "starts at 16: 00" do
      let(:hour) { 16 }

      it "returns the correct blocked start time" do
        blocked_start_time_hour.should eq 14
      end
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
      it 'returns the correct blocked end time' do
        blocked_end_time_hour.should eq 15
        time_slot.blocked_end_time.min.should eq 30
      end
    end

    context "end at 14" do
      let(:hour) { 14 }
      it 'returns the correct blocked end time' do
        blocked_end_time_hour.should eq 16
      end
    end

    context "end at 20" do
      let(:hour) { 20 }
      it 'returns the correct blocked end time' do
        blocked_end_time_hour.should eq 22
      end
    end
  end

  describe "#session_contains?" do
    let(:time_slot) { build(:time_slot) }

    context "calendar time is in time slot" do
      let(:calendar_time) { time_with_zone(hour: 12, min: 0) }

      it "should contains calendar time" do
        time_slot.session_contains?(calendar_time).should be_true
      end
    end

    context "calendar time is not in time slot" do
      let(:calendar_time) { time_with_zone(hour: 18, min: 0) }

      it "should not contains calendar time" do
        time_slot.session_contains?(calendar_time).should_not be_true
      end
    end
  end

  describe "#session_blocks?" do
    let(:time_slot) { build(:time_slot) }

    context "calendar time is blocked in time slot" do
      let(:calendar_time) { time_with_zone(hour: 10, min: 0) }

      it "should contains calendar time" do
        time_slot.session_blocks?(calendar_time).should be_true
      end
    end

    context "calendar time is not blocked in time slot" do
      let(:calendar_time) { time_with_zone(hour: 18, min: 0) }

      it "should not contains calendar time" do
        time_slot.session_blocks?(calendar_time).should_not be_true
      end
    end
  end

  describe '#affordable?' do

    context 'success' do
      let(:time_slot) { build(:time_slot) }

      it 'should be created time slot' do
        time_slot.should be_valid
      end
    end

    context 'failure' do
      let(:time_slot) { build(:time_slot, :with_unaffordable_user)}

      it 'should not be created time slot' do
        time_slot.should_not be_valid
      end
    end
  end

  describe '#cancel_booking_by' do
    let(:user) { create :user, :with_packages }
    let(:time_slot) { create (:time_slot) }
    let!(:admin) { create(:admin) }

    it 'should be destroy' do
      expect { time_slot.destroy_booking }.to change(TimeSlot, :count).by(0)
      expect { AdminMailer.notification_email('cancelled').deliver }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
