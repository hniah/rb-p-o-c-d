module Concerns::SpecialHour::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :hour, :description, :user
    validates :hour, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  end
end
