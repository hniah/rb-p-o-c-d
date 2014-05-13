require "spec_helper"

describe TimeSlot::ModificationMailer do
  describe '#send_modification' do
    let(:mailer) { TimeSlot::ModificationMailer }
    let!(:admin) { create(:admin) }
    let(:last_email) { ActionMailer::Base.deliveries.last }

    it 'should send email' do
      expect{ mailer.send_notification }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(last_email.subject).to eq 'A booking updated!!!'
    end
  end
end
