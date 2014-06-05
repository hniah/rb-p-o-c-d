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

  describe '#index' do
    before { do_request }

    def do_request
      get :index
    end

    it 'should render index layout' do
      response.should render_template :index
    end
  end

  describe '#new' do
    before { do_request }

    def do_request
      get :new
    end

    it 'should render new layout' do
      response.should render_template :new
    end
  end
end
