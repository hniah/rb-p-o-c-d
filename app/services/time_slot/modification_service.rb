class TimeSlot::ModificationService
  attr_accessor :time_slot
  attr_accessor :params

  def initialize(time_slot, params)
    @time_slot, @params = time_slot, params
  end

  def execute!
    @time_slot.attributes = @params
    @time_slot.end_time = @time_slot.start_time + duration
    @time_slot.save!
    notify_admin
  end

  protected
  def notify_admin
    TimeSlot::ModificationMailer.send_notification
  end

  def duration
    @params[:duration].to_i.hours
  end
end
