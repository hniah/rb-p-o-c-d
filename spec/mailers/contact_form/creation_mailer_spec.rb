require "spec_helper"

describe ContactForm::CreationMailer do

  describe "#send_nofitication" do
    let(:mailer) { ContactForm::CreationMailer }
    let!(:admin) { create(:admin) }
    let(:contact_form) { create :contact_form }

    context 'should send mail to admin' do
      let(:sent_mail_admin) { ActionMailer::Base.deliveries.first }

      it "should send correct mail" do
        expect { mailer.send_notification_to_admin(contact_form) }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect(sent_mail_admin.subject).to eq "New Enquiry- OCD contact form"
        expect(sent_mail_admin.to).to include ENV['EMAIL_CONTACT_DEFAULT_TO']
      end
    end

    context 'should send mail to user' do
      let(:sent_mail_user) { ActionMailer::Base.deliveries.last }

      it 'should send correct mail' do
        expect { mailer.send_notification_to_user(contact_form) }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect(sent_mail_user.subject).to eq "Our Cleaning Department: Thank you for your message!"
        expect(sent_mail_user.to).to include contact_form.email
      end
    end
  end
end
