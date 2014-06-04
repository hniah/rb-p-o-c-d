class ContactForm < ActiveRecord::Base
  include Concerns::ContactForm::Validation
end
