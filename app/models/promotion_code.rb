class PromotionCode < ActiveRecord::Base
  include Concerns::RailsAdmin::PromotionCode

  validates_presence_of :code

  belongs_to :package
end
