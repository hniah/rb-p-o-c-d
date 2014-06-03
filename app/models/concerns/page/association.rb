module Concerns::Page::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :page_category
  end
end
