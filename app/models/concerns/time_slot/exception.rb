module Concerns::TimeSlot::Exception
  extend ActiveSupport::Concern

  class NotAffordableError < StandardError

  end

  class UnBookableError < StandardError
    def message
      'Time Slot is only bookable after 2 hours from current time.'
    end
  end
end
