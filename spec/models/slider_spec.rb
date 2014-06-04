require 'spec_helper'

describe Slider do
  context 'Validation' do
    it { should enumerize(:published).in(:publish, :unpublish)}
    it { should validate_presence_of :title}
  end
end
