class User < ActiveRecord::Base
  has_many :bookings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :address, :postal, :contact_number
  validates_acceptance_of :terms_of_service
end
