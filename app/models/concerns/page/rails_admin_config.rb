module Concerns::Page::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        include_all_fields
        field :description do
          formatted_value do
            HTML::FullSanitizer.new.sanitize(bindings[:object].description)
          end
        end
      end

      edit do
        include_all_fields
        field :description, :ck_editor
      end

      show do
        include_all_fields
        field :description do
          formatted_value do
            HTML::FullSanitizer.new.sanitize(bindings[:object].description)
          end
        end
      end
    end
  end
end
