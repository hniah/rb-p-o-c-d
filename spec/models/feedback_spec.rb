require 'spec_helper'

describe Feedback do
  context 'Association' do
    it { should belong_to :user }
    it { should belong_to :housekeeper }
    it { should belong_to :time_slot }
  end

  context 'Validation' do

    describe "#only_one" do
      context "should be created" do
        let(:feedback) { build :feedback }

        it { feedback.should be_valid }
      end

      context "should not be created" do
        let!(:feedback) { create :feedback }
        let(:new_feedback) { build :feedback, time_slot: feedback.time_slot}

        it { new_feedback.should_not be_valid }
      end
    end
  end
end
