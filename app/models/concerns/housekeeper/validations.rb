module Concerns::Housekeeper::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :gender, :contact, :address,
                          :postal, :date_of_birth, :experience_level,
                          :language_spoken, :special_remarks
    validates_date :date_of_birth, :on_or_before => lambda { 18.years.ago }
  end
end
