class TimeSlot::ModificationMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_modification
    mail(to: recipients,
         subject: 'A booking updated!!!',
         template_path:'admin_mailer',
         template_name: 'booking_updated'
    ).deliver
  end

  protected
  def recipients
    Admin.pluck(:email)
  end
end
