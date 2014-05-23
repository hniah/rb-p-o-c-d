module Concerns::SpecialHour::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end
end
