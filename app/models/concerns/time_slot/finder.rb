module Concerns::TimeSlot::Finder
  extend ActiveSupport::Concern

  def total_sessions_in_day(date)
    TimeSlot.where(start_time: date.beginning_of_day..date.end_of_day).count
  end
end
