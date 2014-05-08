class AdminMailer < ActionMailer::Base
  default from: "admin@ourcleaningdepartment.com"

  def notification_email(status_booking)
    admin = Admin.first
    case status_booking
       when 'new'
         mail_to(admin.email, 'New booking made!!!','admin_mailer','booking_made')
       when 'updated'
         mail_to(admin.email, 'A booking updated!!!','admin_mailer','booking_updated')
       when 'canceled'
         mail_to(admin.email, 'A booking canceled!!!','admin_mailer','booking_canceled')
    end
  end

  def mail_to(email, subject, template_path, template_name)
    mail(:to => email,
         :subject => subject,
         :template_path => template_path,
         :template_name => template_name
    )
  end
end
