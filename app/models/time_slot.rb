class TimeSlot < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  belongs_to :housekeeper

  enumerize :category, in: [:booking, :blocked]

  validates_presence_of :start_time, :end_time, :category
  validate :time_is_between_3_to_5_hours, if: :has_start_and_end_time? && :is_booking?

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }

  def time_is_between_3_to_5_hours
    duration = TimeDifference.between(start_time, end_time).in_hours
    if duration < 3 || duration > 5
      errors.add(:end_time, 'must be at between 3 to 5 hours from start time')
    end
  end

  def is_booking?
    self.category == 'booking'
  end

  def has_start_and_end_time?
    self.start_time.present? && self.end_time.present?
  end
end
