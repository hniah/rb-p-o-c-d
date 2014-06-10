class MailchimpApiController < ApplicationController
  def index
  end

  def subscribe
    list_id = ENV['MAILCHIMP_MAILING_LIST_OCD_ID']
    Rails.configuration.mailchimp.lists.subscribe({
                                                   id: list_id,
                                                   email: {email: mailchimp_param['mailchimp_email']},
                                                   double_optin: false,
                                                 })
  flash[:notice] = "Subscribe successfully!!!"
  redirect_to root_path

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to root_path
  end

  protected
  def mailchimp_param
    params.permit(:mailchimp_email)
  end
end
