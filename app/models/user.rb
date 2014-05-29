class User < ActiveRecord::Base
  attr_accessor :package_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Concerns::User::Association
  include Concerns::User::Validations
  include Concerns::User::RailsAdminConfig

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def total_hours_bought
    payments = self.payments.where(status: 'complete')
    payments.map { |p| p.package.hours }.inject(:+).to_i

  end

  def total_hours_used
    hours = self.time_slots.map { |t| t.duration }.inject(:+).to_i
    special_hours = self.special_hours.map { |s| s.hour }.inject(:+).to_i
    hours + special_hours
  end

  def total_hours_current
    self.total_hours_bought - self.total_hours_used
  end
end
