require 'spec_helper'

describe TimeSlot do
  context 'Validation' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :category }
    it { should enumerize(:category).in(:booking, :blocked)}

    describe '#time_is_between_3_to_5_hours' do
      context 'Success' do
        let(:time_slot) { build(:time_slot, end_time: 3.hours.from_now) }

        it 'only accepts 3 to 5 hours duration' do
          time_slot.valid?.should be_true
        end
      end

      context 'Failure' do
        let(:time_slot) { build(:time_slot, end_time: 6.hours.from_now) }

        it 'does not accept any duration outside 3 to 5 hours slot' do
          time_slot.valid?.should be_false
        end
      end
    end
  end

  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
  end
end
