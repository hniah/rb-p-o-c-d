class ContactFormsController < ApplicationController

  def new
    @contact_form = ContactForm.new
  end

  def create
    captcha_message = "The data you entered for the CAPTCHA wasn't correct. Please try again"

    @contact_form = ContactForm.new(contact_params)
    @service = ContactForm::CreationService.new(self)

    if !verify_recaptcha(model: @contact_form, message: captcha_message)
      flash[:alert] = captcha_message
      render :new
    else
      @service.execute!(@contact_form)
    end

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to new_contact_form_path
  end

  def create_contact_form_successful
    flash[:notice] = 'Thank you for leaving us a message. We will get in touch with you within two working days.'
    redirect_to new_contact_form_path
  end

  protected
  def contact_params
    params.permit(:name,
                  :email,
                  :message,
                  :contact
    )
  end
end
