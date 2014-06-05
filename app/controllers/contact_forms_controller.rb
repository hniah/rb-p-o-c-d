class ContactFormsController < ApplicationController

  def index

  end

  def new
    render :new
  end

  def create
    @contact_form = ContactForm.new(contact_params)
    @service = ContactForm::CreationService.new(self)
    @service.execute!(@contact_form)

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to new_contact_form_path
  end

  def create_contact_form_successful
    flash[:notice] = "Contact created successfully"
    redirect_to contact_forms_path
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
