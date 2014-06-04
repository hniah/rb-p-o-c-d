class ContactForm::CreationService < Struct.new(:listener)

  def execute!(contact_form)

    contact_form.save!
    listener.create_contact_form_successful

    notify_admin(contact_form)
    notify_user(contact_form)
  end

  protected
  def notify_admin(contact_form)
    ContactForm::CreationMailer.send_notification_to_admin(contact_form)
  end

  def notify_user(contact_form)
    ContactForm::CreationMailer.send_notification_to_user(contact_form)
  end
end
