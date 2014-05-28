module Concerns::Housekeeper::Association
  extend ActiveSupport::Concern

  included do
    has_many :time_slots
    has_and_belongs_to_many :locations
    has_many :feedbacks
  end
end
