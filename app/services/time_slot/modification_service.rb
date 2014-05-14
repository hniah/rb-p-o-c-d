class TimeSlot::ModificationService
  attr_accessor :time_slot
  attr_accessor :params

  def initialize(time_slot, params)
    @time_slot, @params = time_slot, params
  end

  def execute!
    check_valid?

    @time_slot.attributes = @params
    @time_slot.end_time = @time_slot.start_time + duration.hours

    raise TimeSlot::NotBetweenError unless @time_slot.end_time_valid?(3,5)

    @time_slot.save!
    notify_admin
  end

  protected
  def notify_admin
    TimeSlot::ModificationMailer.send_notification
  end

  def duration
    @params[:duration].to_i
  end

  def check_valid?
    raise "Time Slot is invalid" if duration.nil? || @time_slot.start_time.nil?
    raise TimeSlot::UnBookableError if @time_slot.unbookable_after?(2)
  end
end
