require "spec_helper"

describe TimeSlot::DestructionMailer do

  describe '#send_destruction' do
    let(:mailer) { TimeSlot::DestructionMailer }
    let!(:admin) { create(:admin) }
    let(:time_slot) { create_time_slot(hour: 10, min: 0) }

    context 'should send mail to admin' do
      let(:sent_mail_admin) { ActionMailer::Base.deliveries.first }

      it "should send correct mail" do
        expect { mailer.send_notification_to_admin(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect(sent_mail_admin.subject).to eq "A booking cancelled!!!"
        expect(sent_mail_admin.to).to include admin.email
      end
    end

    context 'should send mail to user' do
      let(:sent_mail_user) { ActionMailer::Base.deliveries.last }

      it 'should send correct mail' do
        expect { mailer.send_notification_to_user(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect(sent_mail_user.subject).to eq "Our Cleaning Department: Booking Cancelled!"
        expect(sent_mail_user.to).to include time_slot.user.email
      end
    end
  end
end
