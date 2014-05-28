class TimeSlot::CreationMailer < ActionMailer::Base
  default from: "admin@ourcleaningdepartment.com"

  add_template_helper TimeSlotsHelper

  def send_notification_to_admin(time_slot)
    @time_slot = time_slot
    mail(to: recipients,
         subject: 'New booking made!!!',
         template_path: 'admin_mailer',
         template_name: 'booking_made'
    ).deliver if recipients.any?
  end

  def send_notification_to_user(time_slot)
    @time_slot = time_slot
    mail(to: time_slot.user.email,
         subject: 'Our Cleaning Department: Booking Confirmation',
         template_path: 'user_mailer',
         template_name: 'booking_made'
    ).deliver
  end

  protected
  def recipients
    Admin.pluck(:email)
  end
end
