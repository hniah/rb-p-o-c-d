class User < ActiveRecord::Base
  attr_accessor :package_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Concerns::User::Association
  include Concerns::User::Validations
  include Concerns::User::RailsAdminConfig

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def total_hours_bought
    packages.map { |p| p.hours }.inject(:+).to_i
  end

  def total_current_hours
    hours = self.time_slots.map { |t| t.duration }.inject(:+).to_i
    total_hours_bought - hours
  end
end
