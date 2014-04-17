class Package < ActiveRecord::Base
  extend Enumerize

  validates_presence_of :session_type, :price, :hours
  validates_numericality_of :hours, :session_type, :price_cents, greater_than: 0

  has_and_belongs_to_many :users, join_table: 'users_packages'

  monetize :price_cents
  enumerize :session_type, in: [3, 4, 5]
end
