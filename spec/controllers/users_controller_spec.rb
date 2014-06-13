require 'spec_helper'

describe UsersController do
  let!(:user){ create(:user) }

  describe "#info" do
    def do_request
      get :info
    end

    it 'should show user information' do
      sign_in user
      do_request
      response.should render_template :info
    end
  end

  describe "#new_promotion" do
    def do_request
      get :new_promotion
    end

    it 'should show user put promotion code' do
      sign_in user
      do_request
      response.should render_template :promotion
    end
  end

  describe "#add_promotion" do
    let!(:promotion_code){create(:promotion_code)}

    def do_request
      patch :add_promotion, code_param
    end

    context 'successful' do
      let(:code_param){
        {'code' => '123ABC'}
      }

      it 'should redirect to user info' do
        sign_in user
        do_request
        response.should redirect_to user_info_path
      end
    end

    context 'failure' do
      context 'promotion code not found' do
        let(:code_param){
          {'code' => 'ABC123'}
        }

        it 'should redirect to user new promotion' do
          sign_in user
          do_request
          response.should redirect_to user_new_promotion_path
        end
      end

      context 'promotion code is used' do
        let!(:promotion_code){ create(:promotion_code, used: true) }
        let(:code_param){
          {'code' => '123ABC'}
        }

        it 'should redirect to user new promotion' do
          sign_in user
          do_request
          response.should redirect_to user_new_promotion_path
        end
      end
    end
  end
end
