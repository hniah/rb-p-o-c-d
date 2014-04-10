class Housekeeper < ActiveRecord::Base
  extend Enumerize

  has_and_belongs_to_many :locations

  enumerize :gender, in: [:male, :female]

  validates_presence_of :name, :gender, :email, :contact, :address, :postal, :date_of_birth
  validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago }
end
