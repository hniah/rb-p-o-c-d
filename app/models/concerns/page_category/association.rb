module Concerns::PageCategory::Association
  extend ActiveSupport::Concern

  included do
    has_many :page
  end
end
