class Page < ActiveRecord::Base
  include Concerns::Page::Validation
  include Concerns::Page::RailsAdminConfig
  include Concerns::Page::Association
end
