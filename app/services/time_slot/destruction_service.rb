class TimeSlot::DestructionService < Struct.new(:listener)
  include TimeSlotsHelper
  include UsersHelper

  def execute!(time_slot)
    unless refund?(time_slot.start_time)
      special_hour = SpecialHour.new
      special_hour.user = time_slot.user
      special_hour.hour = to_durations(time_slot.start_time, time_slot.end_time)
      special_hour.description = "Cancel after a day before 6:15pm. Start time : #{time_slot.start_time}. Housekeeper: #{time_slot.housekeeper.name}"
      special_hour.save!
    end
    time_slot.destroy!
    listener.destroy_time_slot_successful
    notify_admin(time_slot)
    notify_user(time_slot)
  end

  protected
  def notify_admin(time_slot)
    TimeSlot::DestructionMailer.send_notification_to_admin(time_slot)
  end

  def notify_user(time_slot)
    TimeSlot::DestructionMailer.send_notification_to_user(time_slot)
  end
end
