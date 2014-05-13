require "spec_helper"

describe TimeSlot::CreationMailer do

  describe "#send_nofitication" do
    let(:mailer) { TimeSlot::CreationMailer }
    let!(:admin) { create(:admin) }
    let(:sent_mail) { ActionMailer::Base.deliveries.last }

    it "should send correct mail" do
      expect { mailer.send_notification }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(sent_mail.subject).to eq "New booking made!!!"
      expect(sent_mail.to).to include admin.email
    end
  end
end
