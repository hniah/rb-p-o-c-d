module Concerns::Page::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :title
        field :alias
        field :intro_text
        field :description do
          formatted_value do
            HTML::FullSanitizer.new.sanitize(bindings[:object].description)
          end
        end
      end

      edit do
        field :title
        field :alias
        field :intro_text
        field :description, :ck_editor
      end

      show do
        field :title
        field :alias
        field :intro_text
        field :description do
          formatted_value do
            HTML::FullSanitizer.new.sanitize(bindings[:object].description)
          end
        end
      end
    end
  end
end
