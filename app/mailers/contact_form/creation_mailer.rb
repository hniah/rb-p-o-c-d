class ContactForm::CreationMailer < ActionMailer::Base
  default from: ENV['EMAIL_CONTACT_DEFAULT_FROM']
  default to: ENV['EMAIL_CONTACT_DEFAULT_TO']

  def send_notification_to_admin(contact_form)
    @contact_form = contact_form
    mail(subject: 'New Enquiry- OCD contact form',
         template_path: 'admin_mailer',
         template_name: 'new_contact'
    ).deliver
  end

  def send_notification_to_user(contact_form)
    @contact_form = contact_form
    mail(to: contact_form.email,
         subject: 'Our Cleaning Department: Thank you for your message!',
         template_path: 'user_mailer',
         template_name: 'new_contact'
    ).deliver
  end
end
