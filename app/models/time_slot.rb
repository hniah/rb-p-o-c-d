class TimeSlot < ActiveRecord::Base
  extend Enumerize

  attr_accessor :duration

  belongs_to :user
  belongs_to :housekeeper

  enumerize :category, in: [:booked, :blocked]

  validates_presence_of :start_time, :end_time, :category
  validate :time_is_between_3_to_5_hours, if: :has_start_and_end_time? && :booked?

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }

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

  def create_booking_by!(user, duration = 3)
    return false unless self.start_time.is_a?(ActiveSupport::TimeWithZone)
    end_time = self.start_time + duration.hours
    self.end_time = end_time
    self.user = user
    self.category = :booked
    if self.save!
      TimeSlot.new.create_2_hours_apart!(end_time)
    end
  end

  def create_2_hours_apart!(end_time)
    self.category = :blocked
    self.start_time = end_time
    self.end_time = end_time + 2.hours
    self.save!
  end
end
