module Concerns::TimeSlot::Exception
  extend ActiveSupport::Concern

  class NotAffordableError < StandardError

  end

  class UnBookableError < StandardError
    def message
      'Time Slot is only bookable after 2 hours from current time.'
    end
  end

  class NotBetweenError < StandardError
    def message
      'End time must be at between 3 to 5 hours from start time.'
    end
  end

  class OverlapError < StandardError
    def message
      'Time Slot overlaps with another time slot.'
    end
  end

  class ActiveRecord::RecordNotFound
    def message
      'Record is invalid'
    end
  end
end
