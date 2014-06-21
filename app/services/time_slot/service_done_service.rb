class TimeSlot::ServiceDoneService
  include TimeSlotsHelper
  include UsersHelper

  def execute
    list_time_slot = TimeSlot.where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    list_time_slot.each do |t|
      if t.user.time_slots.size == 1 || t.user.time_slots.size % 4 == 0
        if t.end_time < Time.zone.now
          notify_user(t)
        end
      end
    end
  end

  protected
  def notify_user(time_slot)
    TimeSlot::ServiceDoneMailer.send_notification_to_user(time_slot)
  end
end
