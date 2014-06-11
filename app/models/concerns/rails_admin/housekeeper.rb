module Concerns::RailsAdmin::Housekeeper
  extend ActiveSupport::Concern

  included do
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
end
