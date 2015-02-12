class Page < ActiveRecord::Base
  belongs_to :page_category

  include Concerns::RailsAdmin::Page

  validates_presence_of :title, :article_alias, :description
  validates_uniqueness_of :article_alias

  mount_uploader :intro_image, ImagePageUploader
  mount_uploader :full_image, ImagePageUploader

  def previous
    Page.where(["id < ? AND page_category_id = ?", id, page_category_id]).last
  end

  def next
    Page.where(["id > ? AND page_category_id = ?", id, page_category_id]).first
  end
end
