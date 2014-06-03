require 'spec_helper'

describe PagesController do

  context "should show static page" do
    describe "#job_scope_and_time_to_task" do

      def do_request
        get :job_scope_and_time_to_task
      end

      it "should display content" do
        do_request
        response.should render_template :info
      end
    end
  end

  context "should show page with id" do
    describe "#show" do
      let(:page) { create :page }
      def do_request
        get :show, id: page.id
      end

      it 'should display content' do
        do_request
        response.should render_template :info
      end
    end
  end
end
