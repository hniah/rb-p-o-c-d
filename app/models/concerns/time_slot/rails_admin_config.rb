module Concerns::TimeSlot::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :id
        field :overlap? do
          def value
            if bindings[:object].overlap_of?(bindings[:object].housekeeper)
              "Overlap with " + bindings[:object].overlap_of?(bindings[:object].housekeeper).id.to_s
            end
          end
        end
        field :start_time
        field :end_time
        field :category
        field :created_at
        field :updated_at
        field :user
        field :housekeeper
        field :remarks
      end
    end
  end
end
