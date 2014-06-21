class TimeSlot::ServiceDoneMailer < ActionMailer::Base
  default from: ENV['EMAIL_DEFAULT_FROM']

  add_template_helper TimeSlotsHelper

  def send_notification_to_user(time_slot)
    @time_slot = time_slot
    mail(to: time_slot.user.email,
         subject: 'Our Cleaning Department: Service Done',
         template_path: 'user_mailer',
         template_name: 'service_done'
    ).deliver
  end
end
