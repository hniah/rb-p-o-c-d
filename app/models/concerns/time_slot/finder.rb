module Concerns::TimeSlot::Finder
  extend ActiveSupport::Concern

  def total_sessions_in_day(date)
    TimeSlot.where(start_time: date.beginning_of_day..date.end_of_day).count
  end

  extended(TimeSlot) do
    scope :created_after,  -> (date) { where('created_at >= ?', date) }
    scope :created_before, -> (date) { where('created_at <= ?', date) }
  end
end
