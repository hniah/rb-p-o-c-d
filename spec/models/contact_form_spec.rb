require 'spec_helper'

describe ContactForm do

  context 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :message }
    it { should validate_presence_of :contact }
  end
end
