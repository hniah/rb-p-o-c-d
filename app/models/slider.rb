class Slider < ActiveRecord::Base
  extend Enumerize
  enumerize :published, in: [:publish, :unpublish]

  include Concerns::Slider::Validation
  include Concerns::Slider::RailsAdminConfig
  mount_uploader :image, ImageSliderUploader
end
