class Promotion < ActiveRecord::Base
  mount_uploader :image, ImagePromotionUploader

  include Concerns::Promotion::Validation
end
