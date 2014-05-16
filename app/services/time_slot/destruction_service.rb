class TimeSlot::DestructionService < Struct.new(:listener)
  def execute!(time_slot)
    time_slot.destroy!
    listener.destroy_time_slot_successful
    notify_admin
  end

  protected

  def notify_admin
    TimeSlot::DestructionMailer.send_notification
  end
end
