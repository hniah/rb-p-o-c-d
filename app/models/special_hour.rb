class SpecialHour < ActiveRecord::Base
  include Concerns::SpecialHour::Association
  include Concerns::SpecialHour::RailsAdminConfig
  include Concerns::SpecialHour::Validation
end
