

class TimeSlot < ActiveRecord::Base
  extend Enumerize
  extend Concerns::TimeSlot::Finder

  include BookingsHelper
  include Concerns::TimeSlot::Validations
  include Concerns::TimeSlot::Bookable
  include Concerns::TimeSlot::Association

  attr_accessor :duration

  enumerize :category, in: [:booked, :blocked]

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }


  class NotAffordableError < StandardError

  end

  def duration
    (start_time.nil? || end_time.nil?) ?
      3 : to_durations(start_time, end_time)
  end
end
