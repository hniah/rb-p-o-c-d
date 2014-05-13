class Housekeeper < ActiveRecord::Base
  extend Enumerize

  include Concerns::Housekeeper::RailsAdmin
  include Concerns::Housekeeper::Association
  include Concerns::Housekeeper::Validations

  enumerize :gender, in: [:male, :female]
end
