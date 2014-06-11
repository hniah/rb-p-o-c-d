class Slider < ActiveRecord::Base
  include Concerns::RailsAdmin::Slider

  extend Enumerize
  enumerize :published, in: [:publish, :unpublish]

  validates_presence_of :title

  mount_uploader :image, ImageSliderUploader
end
