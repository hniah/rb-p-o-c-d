require 'spec_helper'

describe Package do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :hours }
    it { should validate_numericality_of(:hours).is_greater_than(0) }
    it { should validate_numericality_of(:price_cents).is_greater_than(0) }
  end

  context 'Association' do
    it { should have_and_belong_to_many :users }
  end

end
