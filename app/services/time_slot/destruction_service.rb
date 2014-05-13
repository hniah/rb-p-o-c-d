class TimeSlot::DestructionService
  attr_accessor :time_slot

  def initialize(time_slot)
    @time_slot = time_slot
  end

  def execute!
    @time_slot.destroy!
    notify_admin
  end

  protected

  def notify_admin
    TimeSlot::DestructionMailer.send_notification
  end
end
