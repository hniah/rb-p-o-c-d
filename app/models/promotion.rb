class Promotion < ActiveRecord::Base
  mount_uploader :image, ImagePromotionUploader

  include Concerns::RailsAdmin::Promotion
end
