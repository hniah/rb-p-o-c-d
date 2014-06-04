class Promotion < ActiveRecord::Base
  mount_uploader :image, ImagePromotionUploader

  include Concerns::Promotion::Validation
  include Concerns::Promotion::RailsAdminConfig
end
