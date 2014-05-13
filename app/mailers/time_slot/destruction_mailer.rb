class TimeSlot::DestructionMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_notification
    mail(to: recipients,
         subject: 'A booking cancelled!!!',
         template_path:'admin_mailer',
         template_name: 'booking_cancelled'
    ).deliver
  end

  protected
  def recipients
    Admin.pluck(:email)
  end
end
