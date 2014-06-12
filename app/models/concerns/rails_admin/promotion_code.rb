module Concerns::RailsAdmin::PromotionCode
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        include_all_fields

        field :code do
          visible do
            if bindings[:object].new_record?
              partial :generate_code
            end
          end
        end
      end
    end
  end
end
