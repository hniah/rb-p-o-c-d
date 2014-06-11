class ContactForm < ActiveRecord::Base
  validates_presence_of :name, :email, :message, :contact
end
