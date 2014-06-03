require 'spec_helper'

describe PageCategory do
  context 'Validation' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :page_category_alias}
    it { should validate_uniqueness_of :page_category_alias}
  end

  context 'Association' do
    it { should have_many :page }
  end
end
