class User < ActiveRecord::Base
  has_many :time_slots

  attr_accessor :package_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :address, :postal, :contact_number
  validates_acceptance_of :terms_of_service

  has_and_belongs_to_many :packages, join_table: 'users_packages'
end
