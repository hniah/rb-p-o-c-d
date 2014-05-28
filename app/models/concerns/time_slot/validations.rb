module Concerns::TimeSlot::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :start_time, :end_time, :category

    validate :restrict_booking_time
  end

  def end_time_valid?(from = 3, to = 5)
    duration = to_durations(start_time, end_time)
    if category == 'booked'
      duration >= from && duration <= to
    end
  end

  def overlap_of?(housekeeper)
    time_slots = TimeSlot.all.where.not(id: self.id).where(housekeeper_id: housekeeper.id)
    time_slots.find { |time_slot| self.blocked_by?(time_slot) }
  end

  def restrict_booking_time(start_hour = 8, end_hour = 22)
    return false if self.start_time.nil?
    if self.start_time < self.start_time.change(hour: start_hour) || self.end_time > self.start_time.change(hour: end_hour)
      errors[:base] << "Time Slot is restricted to only #{start_hour} hour to #{end_hour} hour (including PH / weekend)"
    end
  end

  def limit_sessions_in_day?(number_of_sessions = 2, housekeeper)
    TimeSlot.total_sessions_in_day(self.start_time, housekeeper) >= number_of_sessions
  end

  def unbookable_after?(number_of_hour = 2)
    self.start_time <= Time.zone.now + number_of_hour.hours
  end

  def affordable_by?(user, duration)
    user.total_hours_current >= duration
  end

  def refundable?
    day_check = (self.start_time - 1.day).change(hour: 18, min: 15)
    Time.zone.now < day_check
  end
end
