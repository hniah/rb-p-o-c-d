require 'spec_helper'

describe Location do
  context 'Validations' do
    it { should validate_presence_of :name }
  end

  context 'Associations' do
    it { should have_and_belong_to_many :housekeepers }
  end
end
