class Housekeeper < ActiveRecord::Base
  extend Enumerize

  has_many :time_slots
  has_and_belongs_to_many :locations

  enumerize :gender, in: [:male, :female]

  validates_presence_of :name, :gender, :contact, :address, :postal, :date_of_birth
  validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago }

  rails_admin do
    list do
      field :id
      field :name
      field :gender
      field :contact
      field :locations
      field :address
      field :postal
      field :date_of_birth
    end
  end
end
