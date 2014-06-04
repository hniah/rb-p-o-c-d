require 'spec_helper'

describe ContactFormsController do
  describe '#create' do
    let(:contact_params){
      {
        name: 'test',
        email: 'test@example.com',
        message: 'this is test',
        contact: '987-654-321'
      }
    }
    before { do_request }

    def do_request
      post :create, contact_params
    end

    it 'should create contact form successful' do
      flash[:notice] = "Contact is created successfully"
      response.should redirect_to contact_forms_path
    end
  end
end
