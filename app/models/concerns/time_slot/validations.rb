module Concerns::TimeSlot::Validations
  extend ActiveSupport::Concern

  included do
    validate :affordable?
    validates_presence_of :start_time, :end_time, :category
    validate :time_slot_is_between, from: 3, to: 5, if: :has_start_and_end_time? && :booked?
    validate :creatable?
    validate :unbookable_after_hours, number_of_hour: 2
    validate :restrict_booking_time, start_hour: 8, end_hour: 22
    validate :limit_sessions_in_day, number_of_sessions: 2
  end

  def limit_sessions_in_day(number_of_sessions = 2)
    return false if self.start_time.nil?
    if TimeSlot.total_sessions_in_day(self.start_time) == number_of_sessions
      errors[:base] << "Only #{number_of_sessions} sessions in day!"
    end
  end

  def restrict_booking_time(start_hour = 8, end_hour = 22)
    return false if self.start_time.nil?
    if self.start_time < self.start_time.change(hour: start_hour) || self.end_time > self.start_time.change(hour: end_hour)
      errors.add(:time_slot, "is restricted to only #{start_hour} hour to #{end_hour} hour (including PH / weekend)")
    end
  end

  def creatable?
    time_slots = TimeSlot.all
    time_slots.each do |time_slot|
      if self.blocked_by?(time_slot)
        errors.add(:time_slot,'overlaps another time slot')
      end
    end
  end

  def time_slot_is_between(from = 3, to = 5)
    return false if start_time.nil?
    duration = TimeDifference.between(start_time, end_time).in_hours
    if duration < from || duration > to
      errors.add(:end_time, "must be at between #{from} to #{to} hours from start time")
    end
  end

  def has_start_and_end_time?
    self.start_time.present? && self.end_time.present?
  end

  def unbookable_after_hours(number_of_hour = 2)
    return false if self.start_time.nil?
    if self.start_time <= Time.zone.now + number_of_hour.hours
      errors.add(:time_slot, "is only bookable after #{number_of_hour} hours from current time.")
    end
  end

  def affordable?
    return false if start_time.nil?
    return false if user.nil?
    duration = TimeDifference.between(start_time, end_time).in_hours
    if user.total_current_hours - duration < 0
      errors.add(:time_slot,'Have not enough hour in account')
    end
  end
end
