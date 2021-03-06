module Concerns::TimeSlot::Bookable
  extend ActiveSupport::Concern

  BLOCKED_DURATION = 2
  LEAST_SESSION_TIME = 3

  def booked?
    self.category == 'booked'
  end

  def blocked_start_time
    check_time = self.start_time - (BLOCKED_DURATION + LEAST_SESSION_TIME).hours

    if check_time >= check_time.change(hour: 8, min: 0)
      self.start_time - BLOCKED_DURATION.hours
    else
      self.start_time.change(hour: 8, min: 0)
    end
  end

  def blocked_end_time
    check_time = self.end_time + (BLOCKED_DURATION + LEAST_SESSION_TIME).hours

    if check_time <= check_time.change(hour: 22, min: 0)
      self.end_time + BLOCKED_DURATION.hours
    else
      self.end_time.change(hour: 22, min: 0)
    end
  end

  def session_contains?(calendar_time)
    calendar_time >= start_time && calendar_time < end_time
  end

  def session_blocks?(calendar_time)
    calendar_time >= blocked_start_time && calendar_time < blocked_end_time
  end

  def blocked_by?(time_slot)
    (self.start_time >= time_slot.blocked_start_time && self.start_time < time_slot.blocked_end_time) ||
      (self.end_time > time_slot.blocked_start_time && self.end_time <= time_slot.blocked_end_time)
  end

  def can_book?
    return self.user.block == 'unblock'
  end
end
