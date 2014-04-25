module Concerns::TimeSlot::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :housekeeper
  end
end
