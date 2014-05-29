module Concerns::User::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :address, :postal, :contact_number, :alternative_contact_number
    validates_acceptance_of :terms_of_service
  end
end
