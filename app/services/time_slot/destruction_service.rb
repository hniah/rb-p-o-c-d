class TimeSlot::DestructionService < Struct.new(:listener)

  def execute!(time_slot)
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
