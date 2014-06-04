module Concerns::Promotion::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :image
        field :url
        field :description, :ck_editor
      end
    end
  end
end
