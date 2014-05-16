require "spec_helper"

describe TimeSlot::CreationMailer do

  describe "#send_nofitication" do
    let(:mailer) { TimeSlot::CreationMailer }
    let!(:admin) { create(:admin) }
    let(:sent_mail) { ActionMailer::Base.deliveries.last }
    let(:time_slot) { create_time_slot(hour: 10, min: 0) }

    it "should send correct mail" do
      expect { mailer.send_notification(time_slot) }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(sent_mail.subject).to eq "New booking made!!!"
      expect(sent_mail.to).to include admin.email
    end
  end
end
