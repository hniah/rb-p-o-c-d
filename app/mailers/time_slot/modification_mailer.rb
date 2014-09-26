class TimeSlot::ModificationMailer < ActionMailer::Base
  default from: "admin@ourcleaningdepartment.com"

  add_template_helper TimeSlotsHelper

  def send_notification_to_admin(time_slot)
    @time_slot = time_slot

    mail(to: recipients,
         subject: 'A booking updated',
         template_path:'admin_mailer',
         template_name: 'booking_updated'
    ).deliver
  end

  def send_notification_to_user(time_slot)
    @time_slot = time_slot

    mail(to: time_slot.user.email,
         subject: 'Our Cleaning Department: Amended Booking',
         template_path:'user_mailer',
         template_name: 'booking_updated'
    ).deliver
  end

  protected
  def recipients
    Admin.pluck(:email)
  end
end
