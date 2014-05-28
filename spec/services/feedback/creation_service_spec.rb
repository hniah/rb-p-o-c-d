require 'spec_helper'

describe Feedback::CreationService do
  describe "#execute!" do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { Feedback::CreationService.new(listener) }
    let(:time_slot) { create(:time_slot) }
    let(:feedback) { build(:feedback, time_slot: time_slot) }

    before { listener.stub(:create_feedback_successful) }

    it "should create a feedback" do
      expect { service.execute!(feedback) }.to change(Feedback, :count).by 1
    end


    it "should redirect to user info page" do
      expect(listener).to receive(:create_feedback_successful).once
      service.execute!(feedback)
    end
  end

end
