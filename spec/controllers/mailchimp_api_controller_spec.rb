require 'spec_helper'

describe MailchimpApiController do
  before { do_request }

  def do_request
    post :subscribe, mailchimp_param
  end

  let(:mailchimp_param){ {mailchimp_email: 'nghia@futureworkz.com'} }

  it { response.should redirect_to root_path }
end
