require 'spec_helper'

describe User do
  context 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :postal }
    it { should validate_presence_of :contact_number }
    it { should validate_acceptance_of :terms_of_service }
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
end
