class User < ActiveRecord::Base
  include Concerns::RailsAdmin::User

  extend Enumerize
  attr_accessor :package_id

  has_many :time_slots
  has_many :feedbacks
  has_many :payments
  has_many :special_hours
  has_and_belongs_to_many :packages, join_table: 'payments'

  validates_presence_of :name, :address, :postal, :contact_number, :alternative_contact_number, :block
  validates_acceptance_of :terms_of_service

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enumerize :block, in: [:block, :unblock]
  enumerize :changeable_address, in: [:no, :yes]


  DEFAULT_URL = '/images/users/avatars/:style/missing.jpg'
  PATH = '/public/:class/:attachment/:id/:style_:basename.:extension'
  VALIDATE_SIZE = { in: 0..1.megabytes, message: 'Photo size too large. Please limit to 1 mb.' }
  has_attached_file :avatar,
                    styles: {small: '127x127#', thumb: '210x210#', large: '600x600#'},
                    default_url: DEFAULT_URL,
                    path: PATH
  validates_attachment :avatar,
                       content_type: {content_type: /\Aimage\/.*\Z/},
                       size: VALIDATE_SIZE

  after_create do
    subscribe_to_mailchimp if self.subscribe_to_mailing_list
  end

  def total_hours_bought
    payments = self.payments.where(status: 'complete')
    payments.map { |p| p.package.hours }.inject(:+).to_i
  end

  def expire_date
    self.payments.where(status: 'complete').order(created_at: :desc).first
  end

  def total_hours_used
    hours = self.time_slots.map { |t| t.duration }.inject(:+).to_i
    special_hours = self.special_hours.map { |s| s.hour }.inject(:+).to_i
    hours + special_hours
  end

  def total_hours_current
    self.total_hours_bought - self.total_hours_used
  end

  def subscribe_to_mailchimp testing=false
    return true if (Rails.env.test? && !testing)
    list_id = ENV['MAILCHIMP_USER_OCD_ID']

    Rails.configuration.mailchimp.lists.subscribe({
                                                               id: list_id,
                                                               email: {email: self.email},
                                                               name: {name: self.name},
                                                               double_optin: false,
                                                             })
  rescue Gibbon::MailChimpError => e
    case e.code
    when -100
      errors[:base] << 'Please provide a valid email address to join our mailing list.'
    when 214
      errors[:base] << 'This email has already subscribed to our Mailing List.'
    else
      errors[:base] << e.message
    end
  end
end
