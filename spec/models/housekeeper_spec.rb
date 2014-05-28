require 'spec_helper'

describe Housekeeper do
  context 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :gender }
    it { should validate_presence_of :contact }
    it { should validate_presence_of :address }
    it { should validate_presence_of :postal }
    it { should validate_presence_of :date_of_birth }
    it { should validate_presence_of :experience_level }
    it { should validate_presence_of :language_spoken }
    it { should validate_presence_of :special_remarks }
    it { should enumerize(:gender).in(:male, :female) }

    context 'date of birth' do
      context 'Success' do
         let(:housekeeper) { build(:housekeeper, date_of_birth: 18.years.ago) }

        it 'validate date of birth to be at least 18 years old' do
          housekeeper.should be_valid
        end
      end

      context 'Failure' do
        subject(:housekeeper) { build(:housekeeper, date_of_birth: Date.today) }

        it 'date_of_birth is invalid' do
          housekeeper.should_not be_valid
          expect(housekeeper.errors.messages).to include :date_of_birth
        end
      end
    end
  end

  context 'Associations' do
    it { should have_and_belong_to_many :locations }
    it { should have_many :time_slots }
    it { should have_many :feedbacks }
  end
end
