require 'spec_helper'

describe PromotionCode do
  context 'Validation' do
    it { should validate_presence_of :code}
  end

  context 'Association' do
    it { should belong_to :package }
  end
end
