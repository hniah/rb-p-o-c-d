class Housekeeper < ActiveRecord::Base
  extend Enumerize

  has_many :time_slots
  has_and_belongs_to_many :locations

  enumerize :gender, in: [:male, :female]

  validates_presence_of :name, :gender, :contact, :address,
                        :postal, :date_of_birth, :experience_level,
                        :language_spoken, :special_remarks
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

    show do
      field :id
      field :name
      field :gender
      field :contact
      field :locations
      field :address
      field :postal
      field :date_of_birth
      field :date_joined
      field :experience_level
      field :language_spoken
      field :special_remarks
    end

    edit do
      exclude_fields :time_slots
    end
  end
end
