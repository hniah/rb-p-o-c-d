class LatestUpdate < ActiveRecord::Base
  mount_uploader :image, ImageLatestUpdateUploader

  include Concerns::RailsAdmin::LatestUpdate
end
