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
  flash[:notice] = "Thank you for subscribing to our mailing list. We are happy to update you with any new OCD happenings. Have a great day!"
  redirect_to root_path

  rescue Exception => e
    if e.message == "The email parameter should include an email, euid, or leid key"
      flash[:alert] = "Please provide a valid email address to join our mailing list. "
      redirect_to root_path
    else
      flash[:alert] = e.message
      redirect_to root_path
    end
  end

  protected
  def mailchimp_param
    params.permit(:mailchimp_email)
  end
end
