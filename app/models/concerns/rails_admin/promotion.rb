module Concerns::RailsAdmin::Promotion
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :image
        field :url
        field :description, :ck_editor
      end

      list do
        exclude_fields :description, :url
      end

      show do
        include_all_fields
        field :description do
          formatted_value do
            bindings[:object].description.html_safe
          end
        end
      end
    end
  end
end
