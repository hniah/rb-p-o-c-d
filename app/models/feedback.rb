class Feedback < ActiveRecord::Base
  include Concerns::Feedback::Association
  include Concerns::Feedback::Validation
  include Concerns::Feedback::RailsAdminConfig
end
