class MailchimpApiController < ApplicationController

  def subscribe
    list_id = ENV['MAILCHIMP_MAILING_LIST_OCD_ID']
    Rails.configuration.mailchimp.lists.subscribe(
      id: list_id,
      email: {email: mailchimp_param['mailchimp_email']},
      double_optin: false
    )
    flash[:notice] = "Thank you for subscribing to our mailing list."
    redirect_to root_path

  rescue Gibbon::MailChimpError => e
    case e.code
    when -100
      flash[:alert] = "Please provide a valid email address to join our mailing list."
    when 214
      flash[:alert] = "This email has already subscribed to our Mailing List."
    else
      flash[:alert] = e.message
    end
    redirect_to root_path
  end

  protected
  def mailchimp_param
    params.permit(:mailchimp_email)
  end
end
