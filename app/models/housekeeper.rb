class Housekeeper < ActiveRecord::Base
  extend Enumerize

  include Concerns::Housekeeper::RailsAdminConfig
  include Concerns::Housekeeper::Association
  include Concerns::Housekeeper::Validations

  enumerize :gender, in: [:male, :female]
end
