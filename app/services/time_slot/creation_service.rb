class TimeSlot::CreationService
  attr_accessor :time_slot
  attr_accessor :user
  attr_accessor :duration

  def initialize params, user
    @time_slot = TimeSlot.new(params)
    @user = user
    @duration = params.fetch(:duration, 3).to_i
  end

  def execute!
    raise "Time Slot is invalid" if @duration.nil? || @time_slot.start_time.nil?
    raise TimeSlot::NotAffordableError unless @time_slot.affordable_by?(@user, duration)
    raise TimeSlot::UnBookableError if @time_slot.unbookable_after?(2)

    @time_slot.user = user
    @time_slot.end_time = @time_slot.start_time + @duration.hours
    @time_slot.save!

    notify_admin
  end

  protected
  def notify_admin
    TimeSlot::CreationMailer.send_notification
  end
end
