require "spec_helper"

describe TimeSlot::ServiceDoneMailer do

  describe "#send_nofitication" do
    let(:mailer) { TimeSlot::ServiceDoneMailer }
    let(:time_slot) { create_time_slot(hour: 10, min: 0) }

    context 'should send mail to user' do
      let(:sent_mail_user) { ActionMailer::Base.deliveries.first }

      it 'should send correct mail' do
        expect { mailer.send_notification_to_user(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect(sent_mail_user.subject).to eq "Our Cleaning Department: Service Done"
        expect(sent_mail_user.to).to include time_slot.user.email
      end
    end
  end
end
