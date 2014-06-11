module Concerns::RailsAdmin::PageCategory
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :title
        field :page_category_alias
        field :description
      end
    end
  end
end
