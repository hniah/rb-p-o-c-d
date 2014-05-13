require 'spec_helper'

describe TimeSlot::DestructionService do
  describe '#execute!' do
    let(:service) { TimeSlot::DestructionService.new(time_slot) }
    let(:time_slot) { create :time_slot }
    let!(:admin) { create :admin }
    let(:user) { time_slot.user }

    it 'should be destroy' do
      expect(TimeSlot::DestructionMailer).to receive(:send_notification)
      expect{ service.execute! }.to change(TimeSlot, :count).by(0)
    end
  end
end
