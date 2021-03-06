module Concerns::TimeSlot::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :housekeeper
    has_one :feedback
  end
end
