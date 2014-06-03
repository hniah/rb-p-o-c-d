require 'spec_helper'

describe Page do
  context 'Validation' do
    it { should validate_presence_of    :title }
    it { should validate_presence_of    :article_alias }
    it { should validate_uniqueness_of :article_alias }
    it { should validate_presence_of    :description }
  end

  context 'Association' do
    it { should belong_to :page_category }
  end
end
