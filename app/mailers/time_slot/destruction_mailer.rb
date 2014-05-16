class TimeSlot::DestructionMailer < ActionMailer::Base
  default from: "admin@ourcleaningdepartment.com"

  add_template_helper BookingsHelper

  def send_notification(time_slot)
    @time_slot = time_slot
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
