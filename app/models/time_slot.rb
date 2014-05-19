class TimeSlot < ActiveRecord::Base
  extend Enumerize
  extend Concerns::TimeSlot::Finder

  include BookingsHelper
  include Concerns::TimeSlot::Validations
  include Concerns::TimeSlot::Bookable
  include Concerns::TimeSlot::Association
  include Concerns::TimeSlot::Exception
  include Concerns::TimeSlot::RailsAdminConfig

  attr_accessor :duration

  enumerize :category, in: [:booked, :blocked]

  def duration
    (start_time.nil? || end_time.nil?) ?
      3 : to_durations(start_time, end_time)
  end
end
