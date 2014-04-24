module Concerns::TimeSlot::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :housekeeper
    has_and_belongs_to_many :blocked_time_slot
  end
end
