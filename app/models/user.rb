class User < ActiveRecord::Base
  attr_accessor :package_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :address, :postal, :contact_number
  validates_acceptance_of :terms_of_service

  has_many :time_slots
  has_and_belongs_to_many :packages, join_table: 'users_packages'

  def total_hours_bought
    hours = 0
    self.packages.each do |p|
      hours = p.hours + hours
    end
    hours
  end

  def total_hours_available
    hours = 0
    self.time_slots.each do |t|
      number_of_hours = t.end_time.hour - t.start_time.hour
      hours = hours + number_of_hours
    end
    self.total_hours_bought - hours
  end

end
