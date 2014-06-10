require 'spec_helper'

describe User do
  context 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :postal }
    it { should validate_presence_of :contact_number }
    it { should validate_presence_of :alternative_contact_number }
    it { should validate_acceptance_of :terms_of_service }
    it { should validate_presence_of :block }
    it { should enumerize(:block).in(:block, :unblock)}
    it { should enumerize(:changeable_address).in(:no, :yes)}
  end

  context 'Associations' do
    it { should have_many :time_slots }
    it { should have_many :feedbacks }
    it { should have_many :payments }
    it { should have_many :special_hours }
    it { should have_and_belong_to_many :packages}
  end

  describe '#total_hours_bought' do
    context '2 packages' do
      let(:user) { create :user, :with_payments, number_of_payments: 2 }

      it 'should total hours bought' do
        user.total_hours_bought.should eq 24
      end
    end
  end

  describe '#total_hours_used' do
    let(:user) { create :user, :with_time_slots, number_of_time_slots: 2 }
    let!(:special_hours) { create :special_hour, user: user }

    it 'should show total current hours' do
      user.total_hours_used.should eq 10
    end
  end

  describe "#subscribe_to_mailchimp" do
    let(:user_with_subscribe) { create(:user, subscribe_to_mailing_list: true) }
    it "calls mailchimp correctly" do
      opts = {
        email: {email: user_with_subscribe.email},
        name: {name: user_with_subscribe.name},
        id: ENV['MAILCHIMP_USER_OCD_ID'],
        double_optin: false,
      }
      clazz = Rails.configuration.mailchimp.lists.class
      clazz.any_instance.should_receive(:subscribe).with(opts).once
      user_with_subscribe.send(:subscribe_to_mailchimp, true)
    end

    let(:user) { create(:user, subscribe_to_mailing_list: false) }
    it "calls mailchimp correctly" do
      opts = {
        email: {email: user.email},
        name: {name: user.name},
        id: ENV['MAILCHIMP_USER_OCD_ID'],
        double_optin: false,
      }
      clazz = Rails.configuration.mailchimp.lists.class
      clazz.any_instance.should_not_receive(:subscribe).with(opts)
      user.send(:subscribe_to_mailchimp, user.subscribe_to_mailing_list)
    end
  end
end
