module Concerns::User::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        exclude_fields :time_slots, :payments, :packages
      end
    end
  end
end
