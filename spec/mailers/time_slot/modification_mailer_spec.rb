require "spec_helper"

describe TimeSlot::ModificationMailer do
  describe '#send_modification' do
    let(:mailer) { TimeSlot::ModificationMailer }
    let!(:admin) { create(:admin) }
    let(:last_email) { ActionMailer::Base.deliveries.last }
    let(:housekeeper) { create :housekeeper }

    let(:time_slot) { create(:time_slot,
                             start_time: time_with_zone(hour: 12, min: 0),
                             end_time: time_with_zone(hour: 15, min: 0),
                             housekeeper: housekeeper
    )}

    it 'should send email' do
      #expect{ mailer.send_notification_to_admin(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
      #expect(last_email.subject).to eq 'A booking updated!!!'
    end
  end
end
