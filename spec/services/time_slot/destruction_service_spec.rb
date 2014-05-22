require 'spec_helper'

describe TimeSlot::DestructionService do
  describe '#execute!' do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { TimeSlot::DestructionService.new(listener) }
    let(:time_slot) { create :time_slot }
    let!(:admin) { create :admin }
    let(:user) { time_slot.user }

    before { listener.stub(:destroy_time_slot_successful) }

    it 'should be destroy' do
      expect{ service.execute!(time_slot) }.to change(TimeSlot, :count).by(0)
    end

    it 'should redirect to user info page' do
      expect(listener).to receive(:destroy_time_slot_successful).once
      service.execute!(time_slot)
    end

    it 'should send an email to admin' do
      expect(TimeSlot::DestructionMailer).to receive(:send_notification_to_admin)
      service.execute!(time_slot)
    end

    it 'should send an email to user' do
      expect(TimeSlot::DestructionMailer).to receive(:send_notification_to_user)
      service.execute!(time_slot)
    end
  end
end
