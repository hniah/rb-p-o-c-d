class PageCategory < ActiveRecord::Base
  has_many :page

  validates_presence_of :title, :page_category_alias
  validates_uniqueness_of :page_category_alias

  include Concerns::RailsAdmin::PageCategory
end
