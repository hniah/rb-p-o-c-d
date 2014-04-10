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
  end
end
