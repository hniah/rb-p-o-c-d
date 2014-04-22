class TimeSlot < ActiveRecord::Base
  extend Enumerize

  attr_accessor :duration

  belongs_to :user
  belongs_to :housekeeper
  has_and_belongs_to_many :blocked_time_slot

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

  # def time_slots_are_2_hours_apart
  #   time_slots = TimeSlot.all
  #   time_slots.each do |time_slot|
  #     blocked_start_time = time_slot.start_time - 2.hours
  #     blocked_end_time = time_slot.end_time + 2.hours
  #
  #     if self.start_time.between?(blocked_start_time, blocked_end_time)
  #       errors.add(:start_time, 'overlaps another time slot')
  #     end
  #
  #     if self.end_time.between?(blocked_start_time, blocked_end_time)
  #       errors.add(:end_time, 'overlaps another time slot')
  #     end
  #   end
  # end

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
    if self.save
      BlockedTimeSlot.create_blocked_time_slots!(self)
      true
    end
  end
end
