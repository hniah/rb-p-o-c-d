class PromotionCode < ActiveRecord::Base
  include Concerns::RailsAdmin::PromotionCode

  validates_presence_of :code
  validates :hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
end
