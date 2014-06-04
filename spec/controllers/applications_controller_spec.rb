require 'spec_helper'

describe ApplicationController do
  describe '#home' do
    let(:sliders){ create_list :slider, 2 }
    def do_request
      get :home
    end

    it 'should show sliders' do
      do_request
      sliders.count.should eq 2
      response.should render_template :home
    end
  end
end
