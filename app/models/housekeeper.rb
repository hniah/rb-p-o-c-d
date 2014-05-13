class Housekeeper < ActiveRecord::Base
  extend Enumerize

  include Concerns::Housekeeper::RailsAdmin

  has_many :time_slots
  has_and_belongs_to_many :locations

  enumerize :gender, in: [:male, :female]

  validates_presence_of :name, :gender, :contact, :address,
                        :postal, :date_of_birth, :experience_level,
                        :language_spoken, :special_remarks
  validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago }
end
