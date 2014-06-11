module Concerns::RailsAdmin::Payment
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :id
        field :express_token
        field :express_payer_id
        field :user
        field :package
        field :status
      end

      edit do
        exclude_fields :express_token, :express_payer_id, :ip_address
        field :status, :enum do
          help "Please choose status"
          enum do
            ['pending','complete']
          end
        end
      end
    end
  end
end
