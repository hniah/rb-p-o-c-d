class TimeSlot::ModificationService < Struct.new(:listener)

  def execute!(time_slot, params)

    time_slot.attributes = params

    if params[:duration].nil? || time_slot.start_time.nil?
      listener.redirect_to_user_info_path('Time Slot is invalid') and return
    else
      time_slot.end_time = time_slot.start_time + params[:duration].to_i.hours
    end

    if time_slot.unbookable_after?(2)
      listener.redirect_to_user_info_path('Time Slot is only bookable after 2 hours from current time.') and return
    end

    unless time_slot.end_time_valid?(3, 5)
      listener.redirect_to_user_info_path('End time must be at between 3 to 5 hours from start time.') and return
    end

    if time_slot.overlap?
      listener.redirect_to_user_info_path('Time Slot overlaps another time slot.') and return
    end

    time_slot.save!
    listener.update_time_slot_successful

    notify_admin(time_slot)
  end

  protected
  def notify_admin(time_slot)
    TimeSlot::ModificationMailer.send_notification(time_slot)
  end
end
