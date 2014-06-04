module Concerns::Promotion::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :position, :description
  end
end
