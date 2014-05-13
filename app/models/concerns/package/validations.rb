module Concerns::Package::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :session_type, :price
    validates_numericality_of :hours
    validates_numericality_of :price_cents
  end
end
