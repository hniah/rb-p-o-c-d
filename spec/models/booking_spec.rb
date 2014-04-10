require 'spec_helper'

describe Booking do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }

    describe '#time_is_between_3_to_5_hours' do
      context 'Success' do
        it 'only accepts 3 to 5 hours duration' do
          booking = Booking.new(start_time: DateTime.now, end_time: 3.hours.from_now)
          booking.valid?.should be_true
        end
      end

      context 'Failure' do
        it 'does not accept any duration outside 3 to 5 hours slot' do
          booking = Booking.new(start_time: DateTime.now, end_time: 6.hours.from_now)
          booking.valid?.should be_false
        end
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
  end
end
