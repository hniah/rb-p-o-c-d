class TimeSlot::CreationService < Struct.new(:listener)

  def execute!(time_slot, duration, user)
    time_slot.user = user

    if duration.nil? || time_slot.start_time.nil?
      listener.redirect_to_bookings_path('Time Slot is invalid') and return
    else
      time_slot.end_time = time_slot.start_time + duration.hours
    end

    unless time_slot.affordable_by?(user, duration)
      listener.redirect_to_buy_package('Insufficient hours (credit) in account. Please buy packages to booking.') and return
    end

    if time_slot.unbookable_after?(2)
      listener.redirect_to_bookings_path('Time Slot is only bookable after 2 hours from current time.') and return
    end

    unless time_slot.end_time_valid?(3,5)
      listener.redirect_to_bookings_path('End time must be at between 3 to 5 hours from start time.') and return
    end

    if time_slot.overlap_of?(time_slot.housekeeper)
      listener.redirect_to_bookings_path('Time Slot overlaps another time slot.') and return
    end

    time_slot.save!
    listener.create_time_slot_successful

    notify_admin(time_slot)
    notify_user(time_slot)
  end

  protected
  def notify_admin(time_slot)
    TimeSlot::CreationMailer.send_notification_to_admin(time_slot)
  end

  def notify_user(time_slot)
    TimeSlot::CreationMailer.send_notification_to_user(time_slot)
  end
end
