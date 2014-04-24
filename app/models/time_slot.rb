class TimeSlot < ActiveRecord::Base
  extend Enumerize
  include Concerns::TimeSlot::Validations
  include Concerns::TimeSlot::Bookable
  extend Concerns::TimeSlot::Finder
  include Concerns::TimeSlot::Association

  attr_accessor :duration

  enumerize :category, in: [:booked, :blocked]

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }
end
