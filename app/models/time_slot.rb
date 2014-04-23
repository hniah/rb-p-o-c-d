class TimeSlot < ActiveRecord::Base
  extend Enumerize

  attr_accessor :duration

  belongs_to :user
  belongs_to :housekeeper
  has_and_belongs_to_many :blocked_time_slot

  enumerize :category, in: [:booked, :blocked]

  validates_presence_of :start_time, :end_time, :category
  validate :time_is_between_3_to_5_hours, if: :has_start_and_end_time? && :booked?
  validate :only_2_sessions_in_day?, on: :create

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }

  BLOCKED_DURATION = 2
  LEAST_SESSION_TIME = 3

  def time_is_between_3_to_5_hours
    duration = TimeDifference.between(start_time, end_time).in_hours
    if duration < 3 || duration > 5
      errors.add(:end_time, 'must be at between 3 to 5 hours from start time')
    end
  end

  def booked?
    self.category == 'booked'
  end

  def has_start_and_end_time?
    self.start_time.present? && self.end_time.present?
  end

  def create_booking_by(user, duration = 3)
    return false unless self.start_time.is_a?(ActiveSupport::TimeWithZone)
    self.end_time = self.start_time + duration.hours
    self.user = user
    self.category = :booked
    self.save
  end

  def only_2_sessions_in_day?
    if self.start_time.nil?
      return false
    end
    if TimeSlot.total_sessions_in_day(self.start_time) == 2
      return errors[:base] << 'Only 2 sessions in day!'
    end
  end

  def self.total_sessions_in_day(date)
    return TimeSlot.where(created_at: date.beginning_of_day..date.end_of_day).count
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
end
