require 'spec_helper'

describe SpecialHour do
  context 'Association' do
    it { should belong_to :user }
  end

  context 'Validation' do
    it { should validate_presence_of :hour }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user }

    context 'should be from 0 - 1000' do
      context 'valid' do
        let(:special_hour) { build(:special_hour) }

        it { special_hour.should be_valid }
      end

      context 'invalid' do
        let(:special_hour) { build(:special_hour, hour: -2) }

        it { special_hour.should_not be_valid }
      end
    end
  end
end
