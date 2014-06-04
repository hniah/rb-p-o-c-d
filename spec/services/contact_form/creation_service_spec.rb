require 'spec_helper'

describe ContactForm::CreationService do
  describe "#execute!" do
    class StubbedListener; end

    let(:listener) { StubbedListener.new }
    let(:service) { ContactForm::CreationService.new(listener) }
    let(:contact_form) { create(:contact_form) }

    before { listener.stub(:create_contact_form_successful) }

    it "should create a contact form" do
      expect { service.execute!(contact_form) }.to change(ContactForm, :count).by 1
    end


    it "should redirect to contact us page" do
      expect(listener).to receive(:create_contact_form_successful).once
      service.execute!(contact_form)
    end
  end
end
