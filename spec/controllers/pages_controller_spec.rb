require 'spec_helper'

describe PagesController do

  describe "#job_scope_and_time_to_task" do

    def do_request
      get :job_scope_and_time_to_task
    end

    it "should display content" do
      do_request
      response.should render_template :job_scope_and_time_to_task
    end
  end

  describe "#terms_and_condition" do
    def do_request
      get :terms_and_condition
    end

    it "should display content" do
      do_request
      response.should render_template :terms_and_condition
    end
  end

  describe "#disclaimer_privacy_policy" do
    def do_request
      get :disclaimer_privacy_policy
    end

    it "should display content" do
      do_request
      response.should render_template :disclaimer_privacy_policy
    end
  end

  describe "#faq" do
    def do_request
      get :faq
    end

    it "should display content" do
      do_request
      response.should render_template :faq
    end
  end

  describe "#join_us" do
    def do_request
      get :join_us
    end

    it "should display content" do
      do_request
      response.should render_template :join_us
    end
  end
end
