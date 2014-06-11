class Page < ActiveRecord::Base
  belongs_to :page_category

  include Concerns::RailsAdmin::Page

  validates_presence_of :title, :article_alias, :description
  validates_uniqueness_of :article_alias

  mount_uploader :intro_image, ImagePageUploader
end
