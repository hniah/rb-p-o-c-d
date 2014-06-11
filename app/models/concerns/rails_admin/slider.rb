module Concerns::RailsAdmin::Slider
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        exclude_fields :published
      end

      edit do
        exclude_fields :published
      end

      show do
        exclude_fields :published
      end
    end
  end
end
