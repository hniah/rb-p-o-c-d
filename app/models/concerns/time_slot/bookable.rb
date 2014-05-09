module Concerns::TimeSlot::Bookable
  extend ActiveSupport::Concern


  BLOCKED_DURATION = 2
  LEAST_SESSION_TIME = 3

  def booked?
    self.category == 'booked'
  end

  def create_booking_by(user, duration = 3)
    return false if self.start_time.nil?
    self.end_time = self.start_time + duration.hours
    self.user = user
    self.category = :booked
    self.save!
    AdminMailer.notification_email('new').deliver
  end

  def updated(params)
    new_start_time = Time.zone.now.tomorrow.change(
                    year: params["start_time(1i)"].to_i,
                    month: params["start_time(2i)"].to_i,
                    day: params["start_time(3i)"].to_i,
                    hour: params["start_time(4i)"].to_i,
                    min: params["start_time(5i)"].to_i)

    return false if new_start_time.nil?
    self.start_time = new_start_time
    self.end_time = new_start_time + params[:duration].to_i.hours
    self.remarks = params[:remarks]
    if self.save
      AdminMailer.notification_email('updated').deliver
    end
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
    (self.start_time > time_slot.blocked_start_time && self.start_time < time_slot.blocked_end_time) ||
      (self.end_time > time_slot.blocked_start_time && self.end_time < time_slot.blocked_end_time)
  end

  def destroy_booking
    self.destroy!
    AdminMailer.notification_email('cancelled').deliver
  end
end
