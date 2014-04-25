module Concerns::TimeSlot::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :start_time, :end_time, :category
    validate :time_is_between_3_to_5_hours, if: :has_start_and_end_time? && :booked?
    validate :only_2_sessions_in_day, :restrict_booking_time, :creatable?, :unbookable_after_2_hours_from_now
  end

  def only_2_sessions_in_day
    return false if self.start_time.nil?
    if TimeSlot.total_sessions_in_day(self.start_time) == 2
      errors[:base] << 'Only 2 sessions in day!'
    end
  end

  def restrict_booking_time
    return false if self.start_time.nil?
    if self.start_time < self.start_time.change(hour: 8) || self.end_time > self.start_time.change(hour: 22)
      errors.add(:time_slot, 'is restricted to only 8am to 10pm (including PH / weekend)')
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

  def time_is_between_3_to_5_hours
    duration = TimeDifference.between(start_time, end_time).in_hours
    if duration < 3 || duration > 5
      errors.add(:end_time, 'must be at between 3 to 5 hours from start time')
    end
  end

  def has_start_and_end_time?
    self.start_time.present? && self.end_time.present?
  end

  def unbookable_after_2_hours_from_now
    return false if self.start_time.nil?
    if self.start_time <= Time.zone.now + 2.hours
      errors.add(:time_slot, 'is only bookable after 2 hours from current time.')
    end
  end
end
