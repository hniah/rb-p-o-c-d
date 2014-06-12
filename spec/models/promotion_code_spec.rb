require 'spec_helper'

describe PromotionCode do
  context 'Validation' do
    it { should validate_presence_of :code}

    context 'should be from 0 - 1000' do
      context 'valid' do
        let(:promotion_code) { build(:promotion_code) }

        it { promotion_code.should be_valid }
      end

      context 'invalid' do
        let(:promotion_code) { build(:promotion_code, hours: -2) }

        it { promotion_code.should_not be_valid }
      end
    end
  end
end
