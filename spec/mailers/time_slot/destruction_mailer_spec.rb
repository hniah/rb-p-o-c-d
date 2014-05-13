require "spec_helper"

describe TimeSlot::DestructionMailer do

  describe '#send_destruction' do
    let(:mailer) { TimeSlot::DestructionMailer }
    let!(:admin) { create(:admin) }
    let(:last_email) { ActionMailer::Base.deliveries.last }

    it 'should send email' do
      expect { mailer.send_destruction }.to change( ActionMailer::Base.deliveries, :count ).by(1)
      expect(last_email.subject).to eq 'A booking cancelled!!!'
    end
  end
end
