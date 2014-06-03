class PageCategory < ActiveRecord::Base
  include Concerns::PageCategory::Validation
  include Concerns::PageCategory::Association
  include Concerns::PageCategory::RailsAdminConfig
end
