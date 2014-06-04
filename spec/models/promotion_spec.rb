require 'spec_helper'

describe Promotion do

  context 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :position }
    it { should validate_presence_of :description }
  end
end
