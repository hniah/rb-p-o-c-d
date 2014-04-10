require 'spec_helper'

describe Housekeeper do
  context 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :gender }
    it { should validate_presence_of :email }
    it { should validate_presence_of :contact }
    it { should validate_presence_of :address }
    it { should validate_presence_of :postal }
    it { should validate_presence_of :date_of_birth }
    it { should enumerize(:gender).in(:male, :female) }

    context 'date of birth' do
      context 'Success' do
        let(:housekeeper) { build(:housekeeper, date_of_birth: 18.years.ago) }

        it 'validate date of birth to be at least 18 years old' do
          housekeeper.valid?.should be_true
        end
      end

      context 'Failure' do
        let(:housekeeper) { build(:housekeeper, date_of_birth: Date.today) }

        it 'failed validation if less than 18 years old' do
          housekeeper.valid?.should_not be_true
          housekeeper.errors.messages.should include :date_of_birth
        end
      end
    end
  end

  context 'Associations' do
    it { should have_and_belong_to_many :locations }
    it { should have_many :time_slots }
  end
end
