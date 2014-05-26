require 'spec_helper'

describe TimeSlot::DestructionService do
  describe '#execute!' do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { TimeSlot::DestructionService.new(listener) }
    let!(:admin) { create :admin }
    let(:user) { time_slot.user }

    before { listener.stub(:destroy_time_slot_successful) }

    context 'cancell before a day before 6:15pm' do
      let(:time_slot) { create :time_slot }

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

    context 'cancell after a day before 6:15pm' do

      let(:time_slot_not_refund) { create(:time_slot,
                                          start_time: Time.zone.now.change(hour: 8, min: 0) - 2.day,
                                          end_time: Time.zone.now.change(hour: 11, min: 0) - 2.day

      ) }
      it 'should create a special hour' do
        expect { service.execute!(time_slot_not_refund) }.to change(SpecialHour, :count).by(1)
      end

      it 'should be destroy' do
        expect{ service.execute!(time_slot_not_refund) }.to change(TimeSlot, :count).by(0)
      end

      it 'should redirect to user info page' do
        expect(listener).to receive(:destroy_time_slot_successful).once
        service.execute!(time_slot_not_refund)
      end

      it 'should send an email to admin' do
        expect(TimeSlot::DestructionMailer).to receive(:send_notification_to_admin)
        service.execute!(time_slot_not_refund)
      end

      it 'should send an email to user' do
        expect(TimeSlot::DestructionMailer).to receive(:send_notification_to_user)
        service.execute!(time_slot_not_refund)
      end
    end
  end
end
