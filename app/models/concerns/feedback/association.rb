module Concerns::Feedback::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :housekeeper
    belongs_to :time_slot
  end
end
