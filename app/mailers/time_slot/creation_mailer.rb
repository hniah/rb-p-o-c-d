class TimeSlot::CreationMailer < ActionMailer::Base
  default from: "admin@ourcleaningdepartment.com"

  def send_notification
    mail(to: recipients,
         subject: 'New booking made!!!',
         template_path: 'admin_mailer',
         template_name: 'booking_made'
    ).deliver if recipients.any?
  end

  protected
  def recipients
    Admin.pluck(:email)
  end
end
