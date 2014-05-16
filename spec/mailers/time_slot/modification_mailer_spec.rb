require "spec_helper"

describe TimeSlot::ModificationMailer do
  describe '#send_modification' do
    let(:mailer) { TimeSlot::ModificationMailer }
    let!(:admin) { create(:admin) }
    let(:last_email) { ActionMailer::Base.deliveries.last }
    let(:time_slot) { create_time_slot(hour: 10, min: 0) }

    it 'should send email' do
      expect{ mailer.send_notification(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(last_email.subject).to eq 'A booking updated!!!'
    end
  end
end
