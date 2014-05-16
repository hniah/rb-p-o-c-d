module Concerns::Payment::RailsAdminConfig
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
        exclude_fields :express_token, :express_payer_id
      end

    end
  end
end
