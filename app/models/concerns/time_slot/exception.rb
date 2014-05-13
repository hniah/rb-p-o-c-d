module Concerns::TimeSlot::Exception
  extend ActiveSupport::Concern

  class NotAffordableError < StandardError

  end
end
