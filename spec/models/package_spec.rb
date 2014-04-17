require 'spec_helper'

describe Package do
  context 'validations' do
    it { should validate_presence_of :session_type }
    it { should validate_numericality_of(:hours) }
    it { should validate_numericality_of(:price_cents) }
    it { should enumerize(:session_type).in(3, 4, 5)}
  end

  context 'Association' do
    it { should have_and_belong_to_many :users }
  end

  describe ".all_packages_in_array" do
    let!(:packages) do
      create_list :package, 3, session_type: 3
      create_list :package, 3, session_type: 4
      create_list :package, 3, session_type: 5
    end

    it "returns packages in array" do
      result = Package.all_packages_in_array
      result.should_not be_nil
      result.size.should eq 3
      result[3].size.should eq 3
      result[4].size.should eq 3
      result[5].size.should eq 3
    end
  end
end
