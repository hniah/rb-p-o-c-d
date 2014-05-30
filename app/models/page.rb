class Page < ActiveRecord::Base
  include Concerns::Page::Validation
  include Concerns::Page::RailsAdminConfig
end
