module Concerns::User::RailsAdminConfig
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        exclude_fields :time_slots, :payments, :packages, :subscribe_to_mailing_list
      end

      list do
        field :id
        field :email
        field :time_slots
        field :payments
        field :special_hours
        field :packages
        field :number_of_hour_bought do
          label "Total bought hours"
          def value
            bindings[:object].total_hours_bought
          end
        end
        field :number_of_hour_used do
          label "Total available hours"
          def value
            bindings[:object].total_hours_current
          end
        end
      end

      show do
        field :id
        field :email
        field :time_slots
        field :payments
        field :special_hours
        field :packages
        field :number_of_hour_bought do
          label "Total bought hours"
          def value
            bindings[:object].total_hours_bought
          end
        end
        field :number_of_hour_used do
          label "Total available hours"
          def value
            bindings[:object].total_hours_current
          end
        end
        field :name
        field :address
        field :unit
        field :postal
        field :instruction
        field :contact_number
        field :sign_in_count
        field :current_sign_in_at
        field :last_sign_in_at
        field :current_sign_in_ip
        field :last_sign_in_ip
        field :created_at
        field :updated_at
        field :block
      end
    end
  end
end
