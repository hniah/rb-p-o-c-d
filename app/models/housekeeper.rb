class Housekeeper < ActiveRecord::Base
  extend Enumerize
  enumerize :gender, in: [:male, :female]

  validates_presence_of :name, :gender, :email, :contact, :address, :postal, :date_of_birth
  validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago },
                 :before_message => "must be at least 18 years old"
end
