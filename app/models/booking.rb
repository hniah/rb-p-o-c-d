class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :housekeeper

  validates_presence_of :start_time, :end_time
  validate :time_is_between_3_to_5_hours

  def time_is_between_3_to_5_hours
    return if start_time.nil? || end_time.nil?

    duration = TimeDifference.between(start_time, end_time).in_hours

    if duration < 3 || duration > 5
      errors.add(:end_time, 'must be at between 3 to 5 hours from start time')
    end
  end
end
