module Concerns::ContactForm::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :name, :email, :message, :contact
  end
end
