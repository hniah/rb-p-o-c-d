module Concerns::Slider::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title
  end
end
