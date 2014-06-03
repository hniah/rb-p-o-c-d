module Concerns::PageCategory::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :page_category_alias
    validates_uniqueness_of :page_category_alias
  end
end
